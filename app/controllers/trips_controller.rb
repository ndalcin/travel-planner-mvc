class TripsController < ApplicationController

  get '/trips' do
      if logged_in?
        @user = User.find(session[:user_id])
        erb :"/trips/index"
      else
        redirect "/login"
      end
    end

    get '/trips/new' do
      if logged_in?
        erb :"/trips/new"
      else
        redirect "/login"
      end
    end

    post '/trips' do
      if params.has_value?("")
        redirect '/trips/new'
      else
        @trip = Trip.create(name: params[:name], budget: params[:budget], travelers: params[:travelers], user_id: current_user.id)
        @trip.save
        redirect "/trips/#{@trip.id}"
      end
    end

    get "/trips/:id/edit" do
      if logged_in?
        @trip = Trip.find_by_id(params[:id])
        if @trip.user_id == current_user.id
          erb :"/trips/edit"
        else
          redirect '/trips'
        end
      else
        redirect "/login"
      end
    end

    get "/trips/:id" do
      if logged_in?
        @trip = Trip.find_by_id(params[:id])
        erb :"/trips/show"
      else
        redirect '/login'
      end
    end

    patch "/trips/:id" do
      @trip = Trip.find_by_id(params[:id])
      if params.has_value?("")
        redirect "/trips/#{@trip.id}/edit"
      else
        @tweet.update(name: params[:name], budget: params[:budget], travelers: params[:travelers])
        redirect "/trips/#{@trip.id}"
      end
    end

    delete '/trips/:id/delete' do #delete action
      if logged_in?
        @trip = Trip.find_by_id(params[:id])
        if @trip.user_id == current_user.id
          @trip.delete
          redirect to "/home"
        else
          redirect '/trips'
        end
      else
        redirect to '/login'
      end
    end




end
