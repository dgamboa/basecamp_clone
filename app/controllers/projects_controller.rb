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
    @users = User.all
  end

  def create
    user = current_user
    member_emails = project_params.delete(:members)[1..-1]
    @project = Project.new(project_params)
    if @project.save
      Member.create!(project_id: @project.id, user_id: user.id, owner: true)
      member_emails.each do |member|
        user = User.find_by_email(member)
        Member.create(project_id: @project.id, user_id: user.id, owner: false)
      end
      flash[:notice] = "Good luck on your new project"
      redirect_to @project
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
    @users = User.all
  end

  def update
    user = current_user
    project_params = params[:project]
    member_emails = project_params.delete(:members)[1..-1]
    @project = Project.find(params[:id])
    if @project.update_attributes(project_params)
      member_emails.each do |member|
        user = User.find_by_email(member)
        Member.create(project_id: @project.id, user_id: user.id, owner: false)
      end
      redirect_to @project
    else
      render :edit
    end
  end

  def destroy
    Project.find(params[:id]).delete
    redirect_to projects_path
  end

  def destroy_member
    Member.find_by_project_id_and_user_id(params[:project_id], params[:user_id]).destroy
    redirect_to project_path(params[:project_id])
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

  def project_params
    params[:project]
  end
end
