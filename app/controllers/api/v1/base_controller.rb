class Api::V1::BaseController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

  def render_not_found
    render json: { message: 'Resource not found' }, status: 404
  end

  def render_unprocessable_entity
    render json: { message: 'Resource invalid' }, status: 422
  end
end