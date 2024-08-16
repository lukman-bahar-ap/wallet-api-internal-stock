module Api
  class UserController < ApplicationController
    before_action :authenticate_request
    
    def list
      list = UserService.new.list()
      render json: list_response(list) 
    end
  end
end