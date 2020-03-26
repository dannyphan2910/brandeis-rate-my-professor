class ApplicationController < ActionController::Base
    include SessionsHelper
    include SearchHelper

    @current_user = SessionsHelper.current_user
end
