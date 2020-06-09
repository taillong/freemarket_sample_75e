class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @user = current_user
    @parents = Category.where(ancestry: nil)
  end

  def logout
    @parents = Category.where(ancestry: nil)
  end

  def card
    @user = current_user
    @parents = Category.where(ancestry: nil)
  end

end
