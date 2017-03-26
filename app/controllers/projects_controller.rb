class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:update, :destroy]

  def new
    @project = current_user.projects.new
  end

  def index
    @projects = current_user.projects
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
      params.require(:project).permit(:name, :website, :product_hunt_url, :avatar_url)
    end

end
