class TasksController < ApplicationController
  before_action :load_user

  def new
    @task = @user.tasks.new
  end

  def index
    load_collection
  end

  def edit
    load_resource
  end

  def show
    load_resource
    render 'edit'
  end

  def create
    @task = @user.tasks.new(task_params)
    if @task.save
      load_collection
      render 'tasks/index'
    else
      render 'new'
    end
  end

  def update
    load_resource
    if @task.update_attributes(task_params)
      load_collection
    else
      render 'edit'
    end
  end

  protected
  def load_collection
    @tasks = @user.tasks
  end

  def load_resource
    @task = @user.tasks.find_by(id: params[:id])
  end

  def load_user
    @user = current_user
  end

  def task_params
    params.require(:task).permit(:user_id, :description, :start_date, :end_date)
  end
end
