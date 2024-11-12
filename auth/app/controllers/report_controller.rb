class ReportController < ApplicationController
  def index
    render json: { message: 'authenticado com sucesso' }
  end
end