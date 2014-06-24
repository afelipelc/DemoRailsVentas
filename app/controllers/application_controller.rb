class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
#agregado por requisito de Devise
#deshabilitar para permitir el registro del primer usuario
  before_action :authenticate_user!
end
