class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
#agregado por requisito de Devise
#deshabilitar para permitir el registro del primer usuario
  
  # para que acepte los parametros, agregar  el before filter
  # issue https://github.com/ryanb/cancan/issues/835#issuecomment-18663815
  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end
  #si se quiere separar la validacion por controlador
  #se debe agregar before_filter :authenticate_user!, :except => [:some_action_without_auth]
  #sino, lo manejamos de forma general
  before_action :authenticate_user!, :except => [:find]
 
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:email, :password, :password_confirmation, roles: [])}
  end
end
