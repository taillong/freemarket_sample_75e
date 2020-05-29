class ItemsController < ApplicationController
  def index
    @users = User.new
  end
end
