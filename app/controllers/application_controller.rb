# frozen_string_literal: true

# application controller
class ApplicationController < ActionController::Base
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  before_action :set_query
  before_action :user_permit, if: :devise_controller?
  def set_query
    @query = Item.ransack(params[:q])
  end

  private

  def record_not_found
    flash[:alert] = 'Record not found.'
    redirect_to request.referer || root_path
  end

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referer || root_path)
  end

  protected

  def user_permit
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[full_name display_name])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[full_name display_name])
  end
end
