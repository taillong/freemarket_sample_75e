class CardsController < ApplicationController
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
      #binding.pry
      if @card.save
        redirect_to user_path(current_user)
      else
        flash.now[:alert] = @card.errors.full_messages
        binding.pry
        render :new
      end
    end
  end
  
  def show
    @user = current_user
    card = Card.find_by(user_id: current_user.id)
    if card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end

  def edit
    card = Card.where(user_id: current_user.id)
  end

  def update
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjpToken'].blank?
      render :edit
    else 
      @card = Card.find(params[:id])
      customer = Payjp::Customer.retrieve(@card.customer_id)
      card = customer.cards.retrieve(@card.card_id)
      card.card = params['payjpToken']
      #binding.pry
      card.save
      if @card.update(card_id: customer.default_card)
        redirect_to user_path(current_user)
      else
        flash.now[:alert] = @card.errors.full_messages
        binding.pry
        render :edit
      end
    end
  end

  def destroy  
    #binding.pry
    card = Card.find_by(user_id: current_user.id)
    if card.blank?
      edirect_to action: "new" 
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
    redirect_to user_path(current_user)
  end 

end
