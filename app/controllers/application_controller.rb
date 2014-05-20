class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:name, :email, :password, :password_confirmation, :convidado_token)
    end
  end
  private
  def user_not_authorized
    flash[:error] = "No estas autorizado para realizar esta acción."
    redirect_to(request.referrer || root_path)
  end
  def after_sign_in_path_for(resource)
    fiestas_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
