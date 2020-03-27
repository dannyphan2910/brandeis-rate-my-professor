class ApplicationController < ActionController::Base
    include SessionsHelper
    include SearchHelper

    def login_required
        redirect_to('/') if current_user.blank?
    end
end
