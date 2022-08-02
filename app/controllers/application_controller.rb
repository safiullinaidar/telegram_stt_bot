class ApplicationController < ActionController::API
  before_action :check_telegram_token

  def check_telegram_token
    token = request.headers['X-Telegram-Bot-Api-Secret-Token']

    unless token == TELEGRAM_SECURITY_TOKEN
      render json: { error: :authorization_invalid }, status: :forbidden
    end
  end
end
