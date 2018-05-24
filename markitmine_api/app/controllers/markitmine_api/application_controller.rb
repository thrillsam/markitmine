module MarkitmineApi
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :authenticate_api_user!
    before_action :authenticate_api_user_token!

  	protected

    def authenticate_api_user_token!
      if params['apitok'].present?
        token = params['apitok']
      else
        token = request.headers['ApiToken'].present? ? request.headers['ApiToken'] : params['ApiToken']
      end
      api_key = "#{Rails.application.secrets.api_key}"
      if api_key == token
        @token = token
      end
      render json: { errors: "Token Not authenticated" },status: :unauthorized unless @token.present?
    end

  	def authenticate_api_user!
      if params['usertok'].present?
        @user = DeviceConfig.where(user_auth_token: params['usertok']).first.try(:user)
      else
        authenticate_or_request_with_http_token('Token') do |token, options|
          @user = DeviceConfig.where(user_auth_token: token).first.try(:user)
          @user_token = token
  			end
      end
	end
  end
end
