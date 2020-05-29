# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @user = User.new 
  end

  # POST /resource
  def create
    @user = User.new(sign_up_params)
    unless @user.valid?
      flash.now[:alert] = @user.errors.full_messages
      render :new and return
    end
    session["devise_regist_data"] = {user: @user.attributes}
    session["devise_regist_data"][:user]["password"] = params[:user][:password]
    @person_info = @user.build_person_info
    render :new_person_info 
  end

  def create_person_info
    #binding.pry
    @user = User.new(session["devise_regist_data"]["user"])
    @person_info = PersonInfo.new(person_info_params)
    unless @person_info.valid?
      flash.now[:alert] = @person_info.errors.full_messages
      render :new_person_info and return
    end
    @user.build_person_info(@person_info.attributes)
    session["devise_person_info_data"] = {person_info: @person_info.attributes}
    @address = @user.build_address
    render :new_address
  end

  def create_address
    #binding.pry
    @user = User.new(session["devise_regist_data"]["user"])
    @person_info = PersonInfo.new(session["devise_person_info_data"]["person_info"])
    @address = Address.new(address_params)
    unless @address.valid?
      flash.now[:alert] = @address.errors.full_messages
      render :new_address and return
    end
    @user.build_person_info(@person_info.attributes)
    @user.build_address(@address.attributes)
    @user.save
    session["devise_regist_data"]["user"].clear
    session["devise_person_info_data"]["person_info"].clear
    #binding.pry
    sign_in(:user, @user)
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  def person_info_params
    params.require(:person_info).permit(:family_name, :first_name, :family_kana, :first_kana, :birth_date)
    # params.require(:user).permit(person_infos_attributes [:id, :family_name, :first_name, :family_kana, :first_kana, :birth_date)] 
  end

  def address_params
    params.require(:address).permit(:family_name, :first_name, :family_kana, :first_kana, :zipcode, :city, :street, :apartment, :tell, :prefecture_id)
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
