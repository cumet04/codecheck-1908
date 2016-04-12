class ProjectsController < ApplicationController
  def index
    render json: Project.all
  end

  def new
    @project = Project.new
  end

  def show
    @project = Project.find(params[:id])
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @project
    else
      render 'new'
    end
  end

  def destroy
    project = Project.find_by(id: params[:id])
    if !project
      return head 404
    end

    project.destroy
    flash[:success] = "Project deleted"
    redirect_to projects_url
  end

  private

    def project_params
      params.require(:project).permit(:url, :title, :description)
    end
end
