require 'will_paginate/array'
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception
  before_action :update_sanitized_params, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from CanCan::AccessDenied do |exception|  
    flash[:error] = "Access denied!"  
    redirect_to :back  
  end
  rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ::NameError, with: :error_occurred
  rescue_from ::ActionController::RoutingError, with: :error_occurred
  rescue_from ::Exception, with: :error_occurred
  
  protected
  
  def record_not_found(exception)
    render json: {error: exception.message,backtrace:exception.backtrace}.to_json, status: 404
    return
  end
  
  def error_occurred(exception)
    render json: {error: exception.message,backtrace:exception.backtrace}.to_json, status: 500
    return
  end
  
  private

  def user_not_authorized
    flash[:error] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
  def update_sanitized_params
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:email, :password, :password_confirmation,:current_password,
        contact_attributes: [ :name,:room_no,:office_id,:user_id,:contact_no,:intercom,:designation_id])
    end
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :password, :password_confirmation,:current_password,
        contact_attributes: [ :name,:room_no,:office_id,:user_id,:contact_no,:intercom,:designation_id])
    end
  end
end
