class ItemsController < ApplicationController
  before_action :set_item, only: [:destroy]

  def index
    @users = User.new
    @items = Item.limit(3)
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
  end

  def destroy
    if item.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  def edit
    @item = Item.find(params[:id])
    @item.brand_id = @item.brand.name
    # @category = Category.where(id: @item.category.id)
    # binding.pry
  end

  def update
  end




  private
  def item_params
    if brand = Brand.find_by(name: params[:item][:brand_id])
      params[:item][:brand_id] = brand.id
    else
      params[:item][:brand_id] = Brand.create(name: params[:item][:brand_id]).id
    end

    tmp1 = params.require(:item).permit(:name, :explanation, :brand_id,:condition_id, :delivery_fee_id, :prefecture_id, :duration_id, :price, images_attributes: [:src]).merge(seller_id: current_user.id)
    tmp2 = params.permit(:category_id).merge(tmp1)
  end

  def set_item
    item = Item.find(params[:id])
  end
end
