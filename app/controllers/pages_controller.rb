class PagesController < ApplicationController
  def home
    @collections = current_user.collections if user_signed_in?
  end
end
