class ApplicationController < ActionController::API
  include ActionController::MimeResponds
 
  def detail_response(payload)
    return failed_response unless payload

    success_response[:payload] = payload
    success_response
  end

  def list_response(data, page_count = nil)
    return { results: data } unless page_count

    { results: data, count: page_count, total_count: data.total_count }
  end

  def success_response
    @success_response ||= { status: "200", message: "Success" }
  end

  def failed_response
    @failed_response ||= { status: "failed" }
  end

  private

  def authenticate_request
    token = request.headers['Authorization']&.split(' ')&.last
    @current_login = UserLogin.find_by(session_token: token)

    if @current_login.nil?
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def current_login
    @current_login
  end
end