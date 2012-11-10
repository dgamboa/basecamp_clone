class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_owner, only: [:edit, :update, :destroy]
  before_filter :check_access, only: [:show]

  def index
    @user = current_user
    @projects = @user.projects
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
    user = current_user
    @project = Project.new(params[:project])
    if @project.save
      Member.create!(project_id: @project.id, user_id: user.id, owner: true)
      flash[:notice] = "Good luck on your new project"
      redirect_to @project
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      redirect_to @project
    else
      render :edit
    end
  end

  def destroy
    Project.find(params[:id]).delete
    redirect_to projects_path
  end

  private
  def check_access
    if Project.find(params[:id]).private
      unless Member.find_by_project_id_and_user_id(params[:id], current_user.id)
        redirect_to projects_path
      end
    end
  end

  def check_owner
    member = Member.find_by_project_id_and_user_id(params[:id], current_user.id)
    unless member && member.owner
      redirect_to projects_path
    end
  end
end
