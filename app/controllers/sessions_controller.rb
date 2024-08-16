class SessionsController < ApplicationController
  # skip_before_action :authenticate_request, only: [:create]

  def create
    message = failed_response.merge(message: 'username or password must be fill', error: :unauthorized)
    if params[:username].present? &&  params[:password].present? 
      token = UserLoginService.new.auth(params[:username], params[:password])
      if token.present?
        message = success_response.merge(token: token)
      else
        message = failed_response.merge(message: 'Invalid username or password', error: :unauthorized)
      end
    end
    render json: message
  end

  def destroy
    message = failed_response.merge(message: 'Unable to log out', error: :unauthorized)
    if current_login
      current_login.update(session_token: nil)
      message =  message = success_response.merge(message: 'Logged out successfully')
    end
  end
end
