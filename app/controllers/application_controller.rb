class ApplicationController < ActionController::Base

    include ApplicationHelper
   
    protect_from_forgery with: :null_session
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password)}
        
        #devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password)}
    end

    def doorkeeper_unauthorized_render_options(error: nil)
        { json: { error: "Not authorized" } }
    end
    
    def customer_signed_in
        if !customer_signed_in?
          redirect_to '/customers/sign_in', notice: 'please login to continue'
        end
    end
      
    def sellers_signed_in
        if !seller_signed_in?
            redirect_to '/sellers/sign_in', notice: 'please login to continue'
        end
    end

end
