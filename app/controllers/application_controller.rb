class ApplicationController < ActionController::API
  before_action :authorize_request

  private

  def authorize_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    begin
      JsonWebToken.decode(token)
    rescue JsonWebToken::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
