class HomeController < ApplicationController
  def index
  end

  def authenticate
    response = ::Faraday.get('http://auth:3001/report')
    @response = response.body
  end
end