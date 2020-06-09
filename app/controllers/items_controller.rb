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
      redirect_to new_item_path
    end
  end
  
  def edit
    @item = Item.find(params[:id])
    @item.brand_id = @item.brand.name
    
    @images = @item.images

    @category = Category.where(ancestry: nil)
    @category_child = Category.where(id: @item.category.parent().siblings().ids)
    @category_grandchild = Category.where(id: @item.category.siblings().ids)
    @fee = (@item.price * 0.1).round
    @profit = @item.price - @fee

  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to @item
    else
      redirect_to edit_item_path(@item.id)
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def destroy
    @item = Item.find(params[:id])
    if @item.destroy
      redirect_to root_path
    else
      render :show
    end
  end
  
  private
  def item_params
    if brand = Brand.find_by(name: params[:item][:brand_id])
      params[:item][:brand_id] = brand.id
    else
      params[:item][:brand_id] = Brand.create(name: params[:item][:brand_id]).id
    end

    tmp1 = params.require(:item).permit(:name, :explanation, :brand_id,:condition_id, :delivery_fee_id, :prefecture_id, :duration_id, :price, images_attributes: [:src, :_destroy, :id]).merge(seller_id: current_user.id)
    tmp2 = params.permit(:category_id).merge(tmp1)
  end

  def set_item
    item = Item.find(params[:id])
  end
end
