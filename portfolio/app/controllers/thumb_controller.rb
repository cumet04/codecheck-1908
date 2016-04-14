class ThumbController < ApplicationController
  def index
    thumbs = Thumb.all
    id_list = thumbs.map {|t| t[:id]}
    return render json: {thumbs: id_list}
  end

  def show
    thumb = Thumb.find(params[:id])
    send_data thumb.file, :type => 'image/jpeg', :disposition => 'inline'
  end

  def create
    file = params.permit(:file)[:file]
    return head :bad_request unless file
    thumb = Thumb.create({file: file.read})
    return render json: {id: thumb[:id]}
  end

  def destroy
  end
end
