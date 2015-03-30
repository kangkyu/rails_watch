class TasksController < ApplicationController
  before_action :require_user, except: :index

  def index
    @tasks = Task
      .page(params[:page]).per_page(12).date_ordered
  end

  def incomplete
    task_ids = current_user.statuses.where(completed: false).pluck(:task_id)
    @tasks = Task.where(id: task_ids)
      .page(params[:page]).per_page(12).date_ordered
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      User.all.each_with_index do |user, i|
        Status.create(task_id: @task.id, user_id: user.id, completed: false)
      end
      redirect_to tasks_path, notice: "The task was created."
    else
      render 'new'
      flash.now.notice = 'please try again different info'
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:notice] = "This task was updated."
      redirect_to tasks_path(page: (params[:id].to_i/16 + 1))
    else
      render 'edit', notice: 'please try again different'
    end
  end

  def complete
    # Task.where(id: params[:task_ids]).update_all(completed: true)
    @task = Task.find(params[:id])
    status = @task.statuses.find_by(user_id: current_user.id) 
    status.completed = params[:button]
    status.save
    redirect_to :back
  end

  private

  def task_params
    params.require(:task).permit(:episode, :date, :title)
  end
end