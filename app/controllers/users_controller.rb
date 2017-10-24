class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect "/home"
    end
    erb :"/users/new"
  end

  post "/signup" do
    if params.has_value?("")
      redirect "/signup"
    end
    @user = User.create(:username => params[:username], email: params[:email], :password => params[:password])
    session[:user_id] = @user.id
    redirect '/home'
  end

  get '/login' do
    if logged_in?
      redirect "/home"
    end
    erb :"/users/login"
  end

  post "/login" do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/home"
    else
      flash[:notice] = 'You must be logged in to do this'
      redirect "/login"
    end
  end

  get '/home' do
    if logged_in?
      @user = User.find(session[:user_id])
      erb :"/users/show"
    else
      flash[:notice] = 'You must be logged in to do this'
      redirect "/login"
    end
  end

  get "/logout" do
    if logged_in?
  		session.clear
  		redirect "/"
    else
      flash[:notice] = 'You must be logged in to do this'
      redirect "/login"
    end
	end

end
