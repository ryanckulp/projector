class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:update, :destroy]

  def new
    @project = current_user.projects.new
  end

  def index
    @projects = current_user.projects
  end

  def create
    @project = current_user.projects.new(project_params)

    if @project.save
      redirect_to projects_path
    else
      render :edit
    end
  end

  def update
    if @project.update(project_params)
      redirect_to projects_path
    else
      redirect_to @project
    end
  end

  def destroy
    if @project.destroy
      redirect_to projects_path
    else
      redirect_to @project
    end
  end

  private

    def set_project
      @project = current_user.projects.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name, :website, :product_hunt_url, :avatar_url, :custom_message)
    end

end
