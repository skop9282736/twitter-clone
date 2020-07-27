class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :set_action_cable_identifier

    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:account_update, keys: [:avatar])
    end

    private

    def set_action_cable_identifier
      cookies.encrypted[:user_id] = current_user&.id
    end
end
