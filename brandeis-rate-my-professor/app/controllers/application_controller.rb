class ApplicationController < ActionController::Base
    include SessionsHelper
    include SearchHelper
    include MessengerHelper

    before_action :configure_permitted_parameters, if: :devise_controller?
    
    def login_required
        redirect_to('/') unless user_signed_in?
    end

    protected

    # If you have extra params to permit, append them to the sanitizer.
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    end
end
