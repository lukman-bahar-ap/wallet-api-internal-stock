module Api
  class TeamController < ApplicationController
    before_action :authenticate_request
    
    def list
      list = TeamService.new.list()
      render json: list_response(list) 
    end
  end
end