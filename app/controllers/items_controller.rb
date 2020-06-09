class ItemsController < ApplicationController
  before_action :set_item, only: [:destroy, :sell]

  def index
    @users = User.new
    new_items = Item.where(buyer_id: nil)
    @new_items = new_items.last(3)
    pickup = Item.where.not(seller_id: "current_user.id").where(buyer_id: nil)
    random = pickup.shuffle
    @pick_items = random.take(3)
    sold = Item.where.not(buyer_id: nil)
    @sold_items = sold.last(3)
    @parents = Category.where(ancestry: nil)
  end

  def new
    @item = Item.new
    @item.images.new
    @category = Category.where(ancestry: nil)
  end

  def get_category_children
    @category_children = Category.find("#{params[:parent_id]}").children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path 
    else      
      redirect_to new_item_path, flash: { errors: @item.errors.messages }
    end
  end

  def show
    @item = Item.find(params[:id])
    @parents = Category.where(ancestry: nil)
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  def sell
    @user = current_user
    card = Card.find_by(user_id: @user)
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    customer = Payjp::Customer.retrieve(card.customer_id)
    @default_card_information = customer.cards.retrieve(card.card_id)
  end

  private

  def item_params
    tmp1 = params.require(:item).permit(:name, :explanation, :condition_id, :delivery_fee_id, :prefecture_id, :duration_id, :price, images_attributes: [:src]).merge(seller_id: current_user.id)
    tmp2 = params.permit(:category_id).merge(tmp1)
    if params.require(:item).permit(:brand)[:brand] != ""
      brand_id = Item.brand_id_search(params.require(:item).permit(:brand))
      tmp3 = {"brand_id"=> brand_id}.merge(tmp2)
      return tmp3
    else 
      tmp3 = {"brand_id"=> nil}.merge(tmp2)
      return tmp3
    end
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def product_params
    params.require(:product)
  end
end
