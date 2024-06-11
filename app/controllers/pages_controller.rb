class PagesController < ApplicationController
  def home
    if user_signed_in?
      @user_collections = current_user.collections
      @collections = current_user.collections

      if @user_collections.present? && @user_collections.first.albums.any?
        redirect_to collection_path(@user_collections.first) and return
      end
    else
      @user_collections = []
      @collections = []

    end
  end
end
