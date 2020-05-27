class ItemsController < ApplicationController
  def index
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

  private
  def item_params
    tmp = params.require(:item).permit(:name, :explanation, :category_id, :condition_id, :delivery_fee_id, :prefecture_id, :duration_id, :price, images_attributes: [:src])
    params.permit(:category_id).merge(tmp)
  end
end
