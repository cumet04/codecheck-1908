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
    unless input[:thumb]
      flash.now[:danger] = "Thumbnail is not specified"
      return render 'new'
    end
    thumb = Thumb.create({file: input[:thumb].read})

    # TODO: 例外処理がうまくいっていない
    # 下のunlessでパラメータエラーを補足すべきだが、Project.newの時点で例外を吐く
    project = Project.new({
                title: input[:title],
                url: input[:url],
                description: input[:description],
                thumb_id: thumb[:id],
                link_count: 0
              })

    unless project.valid?
      flash.now[:danger] = "Invalid params"
      return render 'new'
    end
    unless project.save
      flash.now[:danger] = "Failed to save the project"
      return render 'new'
    end
    flash[:success] = "The project is created."
    return redirect_to project
  end

  def destroy
    Project.find(params[:id]).destroy
    redirect_to projects_url
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    # FIXME: thumbの扱いが考慮されていない
    # 要素を空で実行すると，その要素は更新されない
    # titleなど，入力必須の項目を空にしても普通に処理は成功する
    # MEMO: replace的な処理にする場合は、idの他にlink_countも引き継ぐ必要あり
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
    input = params.permit(:url, :title, :description, :thumb)

    # thumbを登録する
    return head :bad_request unless input[:thumb]
    thumb = Thumb.create({file: input[:thumb].read})

    project = Project.new({
                title: input[:title],
                url: input[:url],
                description: input[:description],
                thumb_id: thumb[:id],
                link_count: 0
              })

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
    # FIXME: thumbの扱いが考慮されていない
    project = Project.find_by(id: params[:id])
    return head :not_found unless project
    input = params.permit(:url, :title, :description, :thumb)
    project.update(input)
    return render json: project
  end

end
