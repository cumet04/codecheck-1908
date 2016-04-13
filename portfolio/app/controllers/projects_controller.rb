class ProjectsController < ApplicationController

# web-view functions
  def new
    @project = Project.new
  end

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
  end

  def thumb
    @project = Project.find(params[:id])
    send_data @project.thumb, :type => 'image/jpeg', :disposition => 'inline'
  end

  def create
    raw = params.require(:project).
            permit(:url, :title, :description, :thumb)
    input = {}
    input[:title] = raw[:title]
    input[:url] = raw[:url]
    input[:description] = raw[:description]
    input[:thumb] = raw[:thumb] ? raw[:thumb].read : nil
    project = Project.new(input)
    return head :bad_request           unless project.valid?
    return head :internal_server_error unless project.save
    # FIXME: thumb要素がjsonに出力できないのでコケる
    return render json: project
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
    project = Project.new(params.
                permit(:url, :title, :description, :thumb))
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

end
