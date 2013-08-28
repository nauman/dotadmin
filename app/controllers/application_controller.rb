class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  # cancan fix https://github.com/ryanb/cancan/issues/571
  # strong parameters with cancan bug
  # ActiveModel::ForbiddenAttributesError
  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name,
                                                            :email, :password, :password_confirmation, :role, :authenticity_token) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name,
                                                                   :email, :password, :password_confirmation, :current_password, :role, :authenticity_token) }
  end

end
