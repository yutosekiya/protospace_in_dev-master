class TagsController < ApplicationController
  def index
    @tags = Tag.all
  end

  def create
  end

  def show
    @prototypes = Tag.find(params[:id]).prototypes.page(params[:page]).per(5)
  end
end
