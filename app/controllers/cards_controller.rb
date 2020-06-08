class CardsController < ApplicationController
  # require 'payjp'
  require "payjp"

  def new
    card = Card.where(user_id: current_user.id)
    redirect_to root_path if card.exists?
    # @card = Card.new
    # @card = Card.where(user_id: current_user.id)
    # @user = User.find(params[:id])
  end

  def create 
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjpToken'].blank?
      #binding.pry
      render :new
    else 
      customer = Payjp::Customer.create(
        description: 'test',
        email: current_user.email,
        card: params['payjpToken'],
        metadata: {user_id: current_user.id}
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      binding.pry
      if @card.save
        redirect_to root_path
      else
        flash.now[:alert] = @card.errors.full_messages
        binding.pry
        render :new
      end
    end
  end
  
  def show
    #binding.pry
    @user = current_user
    card = Card.find_by(user_id: current_user.id)
    #card = Card.find(params[:current_user.cards.id])
    if card.blank?
      redirect_to action: "new" 
    else
      #binding.pry
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
      #binding.pry
    end
  end

  # def edit
  # end

  def update
  end

  def destroy
  end 

end
