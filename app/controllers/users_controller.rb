class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id 
      Task.all.each_with_index do |task, i|
        if task.title != 'cancel'
          Status.create(user_id: @user.id, task_id: i+1, completed: false)
        end
      end
      redirect_to root_url, notice: "Thank you for signing up"
    else
      render "new"
    end
  end

private
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
    
  end
end