class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :user_parents
  before_action :user_current, only: [:show, :card]
  
  def show; end

  def logout; end

  def card; end

  private 

  def user_parents
    @parents = Category.where(ancestry: nil)
  end

  def user_current
    @user = current_user
  end
end
