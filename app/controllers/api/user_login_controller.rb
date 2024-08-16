module Api
  class UserLoginController < ApplicationController 
    before_action :authenticate_request
    
    def list
      list = UserLoginService.new.list()
      render json: list_response(list) 
    end
  end
end