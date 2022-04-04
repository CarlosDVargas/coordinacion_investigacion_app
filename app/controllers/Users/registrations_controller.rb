# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  prepend_before_action :require_no_authentication, only: [:new, :create, :cancel]
  skip_before_action :require_no_authentication, only: [:new, :create]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    @user = User.new()
    @user.firstname = params[:user][:firstname]
    @user.lastname = params[:user][:lastname]
    @user.email = params[:user][:email]
    @user.id_number = params[:user][:id_number]
    @user.phone_number = params[:user][:phone_number]
    @user.email = params[:user][:email]
    @user.password = "Con#{@user.id_number}"
    @user.role = @user.defined_enums["role"].key(params[:user][:role])
    if @user.save
      redirect_to root_path
    else
      redirect_to new_user_registration_path(@user)
    end
  end

  def index
    @user = User.new
    if !params[:firstname].blank? || !params[:lastname].blank? || !params[:email].blank? || !params[:id_number].blank?
      @users = []
      if !params[:firstname].blank?
        users_by_first_name = User.where("firstname like ?", "%" + params[:firstname] + "%")
        @users = @users.concat(users_by_first_name) if !users_by_first_name.empty?
      end
      if !params[:lastname].blank?
        users_by_last_name = User.where("lastname like ?", "%" + params[:lastname] + "%")
        @users = @users + users_by_last_name if !users_by_last_name.empty?
      end
      if !params[:email].blank?
        users_by_email = User.where("email like ?", "%" + params[:email] + "%")
        @users = @users.concat(users_by_email) if !users_by_email.empty?
      end
      if !params[:id_number].blank?
        users_by_id_number = User.where("id_number like ?", "%" + params[:id_number] + "%")
        @users = @users.concat(users_by_id_number) if !users_by_id_number.empty?
      end
    else
      @users = User.all
    end
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

  # protected

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
