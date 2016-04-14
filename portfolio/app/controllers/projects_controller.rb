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

  def create
    input = params.require(:project).permit(:url, :title, :description, :thumb)

    # thumbを登録する
    return head :bad_request unless input[:thumb]
    thumb = Thumb.create({file: input[:thumb].read})

    project = Project.new({
                title: input[:title],
                url: input[:url],
                description: input[:description],
                thumb_id: thumb[:id]
            })

    # FIXME: 戻り値処理がwebviewのそれになっていない...？
    return head :bad_request           unless project.valid?
    return head :internal_server_error unless project.save
    return render json: project
  end

  def destroy
    Project.find(params[:id]).destroy
    redirect_to projects_url
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    # 要素を空で実行すると，その要素は更新されない
    # titleなど，入力必須の項目を空にしても普通に処理は成功する
    project = Project.find(params[:id])
    input = params.require(:project).
            permit(:url, :title, :description, :thumb)
    project.update(input)
    redirect_to project_path(project)
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

  def api_update
    project = Project.find_by(id: params[:id])
    return head :not_found unless project
    input = params.permit(:url, :title, :description, :thumb)
    project.update(input)
    return render json: project
  end

end
