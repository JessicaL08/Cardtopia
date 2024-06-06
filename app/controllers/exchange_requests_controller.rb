class ExchangeRequestsController < ApplicationController
  before_action :authenticate_user!

  def create
    @pokemon = Pokemon.find(params[:pokemon_id])
    @exchange_request.pokemon = @pokemon
    @exchange_request = current_user.exchange_requests.new(exchange_request_params)

    if @exchange_request.save
      redirect_to albums_path, notice: 'Carte mise à disposition pour échange.'
    else
      redirect_to albums_path, alert: 'Erreur lors de la mise à disposition de la carte.'
    end
  end

  private

  def exchange_request_params
    params.require(:exchange_request).permit(:pokemon_id, :postal_code)
  end
end
