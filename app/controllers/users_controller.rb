class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @user = User.find(params[:id])
  end

  def logout
  end

  def card
    @user = current_user
  end

end
