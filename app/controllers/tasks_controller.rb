class TasksController < ApplicationController
  def new
    @task    = Task.new
    @list    = List.find(params[:list_id])
    @project = Project.find(params[:project_id])
    @doers   = @project.users
  end

  def create
    @task   = Task.new(params[:task])
    project = Project.find(params[:project_id])
    list    = List.find(params[:list_id])
    @task.list = list
    @task.author = current_user
    if @task.save
      redirect_to project
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
