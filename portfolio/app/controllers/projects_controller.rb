class ProjectsController < ApplicationController
  def index
    render json: Project.all
  end

  def new
  end

  def show
    project = Project.find_by(id: params[:id])
    return head :not_found unless project
    return render json: project
  end

  def create
    project = Project.new(project_params)
    return head :bad_request           unless project.valid?
    return head :internal_server_error unless project.save
    return render json: project
  end

  def destroy
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
