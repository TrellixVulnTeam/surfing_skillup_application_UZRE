# frozen_string_literal: true


class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @user = User.new(user_params)
  end

  # POST /resource
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "登録しました！"
      if current_user.admin
        redirect_to user_url
      else
        redirect_to new_user_session_url
      end
    else
      render 'new'
    end
  end

  # GET /resource/edit
  def edit
  end

  # PUT /resource
  def update
    @user.update_attributes(user_account_params)
    flash[:success] = "アカウント情報を更新しました"
    redirect_to root_url
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource``æ`«`‘`…`……`……………………/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    super
  end

  private

  def user_params
    params.require(:user).permit(:name, :name_call, :tel, :email, :birthday, :using_surfboard, :admin, :password, :password_confirmation)
  end

  def user_account_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  end

  # The path used after sign up.
    def after_sign_up_path_for(resource)
      super(resource)
    end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    super(resource)
  end
end