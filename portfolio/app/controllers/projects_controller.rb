class ProjectsController < ApplicationController

# web-view functions
  def new
  end

  def index
  end

  def show
    @project = Project.find(params[:id])
  end

  def create
  end

  def destroy
  end

# API functions
  def api_index
    render json: Project.all
  end

  def api_show
    project = Project.find_by(id: params[:id])
    return head :not_found unless project
    return render json: project
  end

  def api_create
    project = Project.new(project_params)
    return head :bad_request           unless project.valid?
    return head :internal_server_error unless project.save
    return render json: project
  end

  def api_destroy
    project = Project.find_by(id: params[:id])
    return head :not_found unless project

    project.destroy
    return render json: {msg: "Project" + params[:id] + " was deleted"}
  end

  private

    def project_params
      params.permit(:url, :title, :description)
    end
end
