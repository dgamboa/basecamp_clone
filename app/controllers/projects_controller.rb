class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_access, only: [:show]

  def index
    @user = current_user
    @projects = @user.projects + @user.owned_projects
  end

  def show
    @project = Project.find(params[:id])
    @members = @project.users
    @lists = @project.lists
  end

  def new
    @project = Project.new
  end

  def create
    @project = current_user.owned_projects.new(project_params)
    if @project.save
      flash[:notice] = "Good luck on your new project"
      redirect_to @project
    else
      render :new
    end
  end

  def edit
    @project = current_user.owned_projects.find(params[:id])
  end

  def update
    @project = current_user.owned_projects.find(params[:id])
    if @project.update_attributes(project_params)
      redirect_to @project
    else
      render :edit
    end
  end

  def destroy
    current_user.owned_projects.find(params[:id]).delete
    redirect_to projects_path
  end

  private

  def check_access
    @project = Project.find(params[:id])
    unless @project.public? || @project.users.include?(current_user)
      redirect_to projects_path
    end
  end

  def project_params
    params[:project]
  end
end
