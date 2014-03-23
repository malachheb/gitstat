class API::ApplicationController < ApplicationController

  rescue_from Mongoid::Errors::DocumentNotFound, with: :record_not_found

  respond_to :json

  def parse_body_json
    @attributes = JSON.parse(request.body.read)
  end

  def record_not_found
    render :json => {:msg => 'Resource not found'}, :status => :not_found, :code => 404
  end
  
end
