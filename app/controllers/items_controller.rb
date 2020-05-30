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
      redirect_to new_item_path, flash: { errors: @item.errors.messages }
    end
  end

  private
  def item_params
    tmp1 = params.require(:item).permit(:name, :explanation, :condition_id, :delivery_fee_id, :prefecture_id, :duration_id, :price, images_attributes: [:src])
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
end
