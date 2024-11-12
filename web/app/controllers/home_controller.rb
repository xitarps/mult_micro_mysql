class HomeController < ApplicationController
  def index
  end

  def authenticate
    binding.irb
    response = ::Faraday.get('http://178.0.0.2:3001/report')
    @response = response.body
  end
end