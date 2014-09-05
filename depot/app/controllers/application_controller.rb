class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #before_action :authorize
#  before_action :authenticate_user!
  def check_privileges!
    redirect_to "/", notice: "You dont have enough privileges to be here" unless current_user.role == "admin"
  end
  protect_from_forgery with: :exception
  before_action :set_i18n_locale_from_params
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected
   def set_i18n_locale_from_params
     if params[:locale]
       if I18n.available_locales.map(&:to_s).include?(params[:locale])
          I18n.locale = params[:locale]
       else
         flash.now[:notice] = 
           "#{params[:locale]} translation not available"
         logger.error flash.now[:notice]
       end
     end
   end

   def default_url_options
     { locale: I18n.locale }
   end


def configure_permitted_parameters
  devise_parameter_sanitizer.for(:sign_up){|u|u.permit(:name, :email, :password, :password_confirmation, :user_name, :gender, :image)}
  devise_parameter_sanitizer.for(:account_update) << :name
end
end


