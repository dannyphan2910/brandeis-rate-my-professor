# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
<<<<<<< HEAD
=======
  skip_before_action :verify_authenticity_token
>>>>>>> c690c1544f33ef95f3c794339d01804c697bb601
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
<<<<<<< HEAD
    super
    puts resource.valid?
  end

  # DELETE /resource/sign_out
  # def destroy
  #   signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
  #   set_flash_message! :notice, :signed_out if signed_out
  #   log_out
  #   redirect_to root_url
  # end

  protected
=======
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    log_in current_user
    redirect_to root_url
  end

  # DELETE /resource/sign_out
  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message! :notice, :signed_out if signed_out
    log_out
    redirect_to root_url
  end

  # protected
>>>>>>> c690c1544f33ef95f3c794339d01804c697bb601

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
<<<<<<< HEAD

  def after_sign_in_path_for(resource)
    puts resource.errors.full_messages.join(', ')
  end
=======
>>>>>>> c690c1544f33ef95f3c794339d01804c697bb601
end
