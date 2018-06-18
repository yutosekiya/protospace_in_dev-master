class PrototypesController < ApplicationController
  before_action :user_logged_in?, except: :index
  before_action :set_prototype, only: [:show, :edit, :update, :destroy]
  before_action :set_thumbnail, only: [:edit, :update]
  before_action :set_tags,      only: [:edit, :update]

  def index
    @prototypes = Prototype.page(params[:page]).per(5)
  end

  def new
    @prototype = Prototype.new
    @prototype.captured_images.build
    @prototype.tags.build
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to :root, notice: 'New prototype was successfully created'
    else
      redirect_to ({ action: new }), alert: 'YNew prototype was unsuccessfully created'
     end
  end

  def show
  end

  def edit
    (3 - @sub_thumbnails.length).times do
      @sub_thumbnails << @prototype.captured_images.sub.new
    end
    (Prototype::MAX_TAG_LENGTH - @tags.length).times do
      @prototype.tags.build
    end
  end

  def update
    if @prototype.update(prototype_params)
      redirect_to @prototype, notice: "Prototype has edited successfully."
    else
      render edit_prototype_path(@prototype)
    end
  end

  def destroy
      @prototype.destroy if current_user.id == @prototype.user_id
      redirect_to :root
  end

  private

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def set_thumbnail
    @main_thumbnail = @prototype.captured_images.main
    @sub_thumbnails = @prototype.captured_images.sub
  end

  def set_tags
    @tags = @prototype.tags
  end

  def prototype_params
    params.require(:prototype).permit(
      :title,
      :catch_copy,
      :concept,
      :user_id,
      captured_images_attributes: [:id, :content, :status],
      tags_attributes: [:id, :content]
    )
  end
end
