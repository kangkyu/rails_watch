class SessionsController < ApplicationController

  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to tasks_url, notice: "Logged in"
    else
      flash.now.alert = "Id or Password invalid"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to tasks_url, notice: "Logged out "
  end
end