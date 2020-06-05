class CardsController < ApplicationController
  # require 'payjp'
  require "payjp"

  def new
    card = Card.where(user_id: current_user.id)
    # redirect_to action: "show" if card.exists?
    # @card = Card.new
    # @card = Card.where(user_id: current_user.id)
    # @user = User.find(params[:id])
  end

  def create 
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjpToken'].blank?
      render :new
    else 
      customer = Payjp::Customer.create(
        card: params['payjp-token']
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to root_path
      else
        render :new
      end
    end
  end

end
