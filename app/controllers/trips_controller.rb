class TripsController < ApplicationController

  get '/trips' do
      if logged_in?
        @user = User.find(session[:user_id])
        erb :"/trips/index"
      else
        flash[:notice] = "Please login to see this page"
        redirect "/login"
      end
    end

    get '/trips/new' do
      if logged_in?
        erb :"/trips/new"
      else
        flash[:notice] = "Please login to see this page"
        redirect "/login"
      end
    end

    post '/trips' do
      @trip = Trip.create(params[:trip])
      @trip.user_id = current_user.id
      if !params[:departure_city].empty?
        flight = Flight.find_by(departure_city: params[:departure_city])
        if flight
          @trip.flight = flight
        else
          @trip.flight = Flight.create(departure_city: params[:departure_city])
        end
      elsif params[:flight][:departure]
        @trip.flight_id = params[:flight][:departure]
      end
        @trip.save
        flash[:notice] = "Your trip was added successfully!"
        redirect "/trips/#{@trip.id}"
    end

    get "/trips/:id/edit" do
      if logged_in?
        @trip = Trip.find_by_id(params[:id])
        if @trip.user_id == current_user.id
          erb :"/trips/edit"
        else
          flash[:notice] = "This is not your trip to edit!"
          redirect '/trips'
        end
      else
        flash[:notice] = "Please login to see this page"
        redirect "/login"
      end
    end

    get "/trips/:id" do
      if logged_in?
        @trip = Trip.find_by_id(params[:id])
        if !@trip
          flash[:notice] = "This does not exist!"
          redirect '/home'
        end
        erb :"/trips/show"
      else
        flash[:notice] = "Please login to see this page"
        redirect '/login'
      end
    end

    post "/trips/:id" do
      @trip = Trip.find_by_id(params[:id])
      @trip.update(params[:trip])
      if !params[:departure_city].empty?
        flight = Flight.find_by(departure_city: params[:departure_city])
        if flight
          @trip.flight = flight
        else
          @trip.flight = Flight.create(departure_city: params[:departure_city])
        end
      elsif params[:flight][:departure]
        @trip.flight_id = params[:flight][:departure]
      end
        @trip.save
        flash[:notice] = "Your trip was updated successfully!"
        redirect "/trips/#{@trip.id}"
    end

    delete '/trips/:id/delete' do #delete action
      if logged_in?
        @trip = Trip.find_by_id(params[:id])
        if @trip.user_id == current_user.id
          @trip.delete
          flash[:notice] = "Your trip was deleted successfully!"
          redirect to "/home"
        else
          redirect '/trips'
        end
      else
        flash[:notice] = "Please login to see this page"
        redirect to '/login'
      end
    end


end
