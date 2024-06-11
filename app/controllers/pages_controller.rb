class PagesController < ApplicationController
  before_action :authenticate_user!

  def home
    @user_collections = current_user.collections

    if @user_collections.present? && @user_collections.first.albums.any?
      redirect_to collection_path(@user_collections.first)
    else
      @collections = current_user.collections if user_signed_in?
    end
  end
end
