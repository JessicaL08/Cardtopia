class PagesController < ApplicationController
  def home
    redirect_to albums_path if user_signed_in?
  end
end
