class CollectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_collection, only: [:show, :edit, :update, :destroy]

  def index
    @collections = current_user.collections
  end

  def show
  end

  def new
    @collection = current_user.collections.build
  end

  def create
    @collection = current_user.collections.build(collection_params)
    if @collection.save
      redirect_to collection_path(@collection), notice: 'Collection created successfully.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @collection.update(collection_params)
      redirect_to collection_path(@collection), notice: 'Collection updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    # raise
    @collection.destroy
    redirect_to collections_path, notice: 'Collection deleted successfully.'
  end

  private

  def set_collection
    @collection = Collection.find(params[:id])
  end

  def collection_params
    params.require(:collection).permit(:name)
  end
end
