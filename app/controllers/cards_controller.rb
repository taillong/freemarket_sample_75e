class CardsController < ApplicationController
  require "payjp"

  def new
    card = Card.where(user_id: current_user.id)
    redirect_to root_path if card.exists?
  end

  def create 
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjpToken'].blank?
      render :new
    else 
      customer = Payjp::Customer.create(
        description: 'test',
        email: current_user.email,
        card: params['payjpToken'],
        metadata: {user_id: current_user.id}
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to user_path(current_user)
      else
        flash.now[:alert] = @card.errors.full_messages
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
      card.save
      if @card.update(card_id: customer.default_card)
        redirect_to user_path(current_user)
      else
        flash.now[:alert] = @card.errors.full_messages
        render :edit
      end
    end
  end

  def destroy  
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
  
  def buy
    @item = Item.find(params[:id])
    card = current_user.card
    if @item.buyer_id.present?
      flash[:alert] = "売り切れです"
      redirect_to root_path
    elsif card.blank?
      redirect_to action: "new"
      flash[:alert] = "購入にはクレジットカード登録が必要です"
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      Payjp::Charge.create(
      amount: @item.price,
      customer: card.customer_id,
      currency: 'jpy',
      )
      binding.pry
      if @item.update(buyer_id: current_user.id)
        flash[:notice] = '購入しました。'
        redirect_to controller: 'items', action: 'show', id: @item.id
      else
        flash[:alert] = '購入に失敗しました。'
        redirect_to controller: 'items', action: 'show', id: @item.id
      end
    end
  end
end
