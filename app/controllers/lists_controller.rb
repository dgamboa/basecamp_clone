class ListsController < ApplicationController
  def new
    @list = List.new
    @project = Project.find(params[:project_id])
  end

  def create
    @list = List.new(params[:list])
    project = Project.find(params[:project_id])
    @list.project = project
    if @list.save
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
