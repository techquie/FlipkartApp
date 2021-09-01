class ApplicationController < ActionController::Base

    include ApplicationHelper
   
    protect_from_forgery with: :null_session
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password)}
        
        #devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password)}
    end

=begin    
    #before_action :authorized
    helper_method :current_user
    helper_method :logged_in?

    def current_user    
        Customer.find_by(id: session[:user_id])
    end

    def logged_in?
        !current_user.nil?
    end

    def authorized   
       redirect_to '/flipkart' unless logged_in?
    end
=end
end
