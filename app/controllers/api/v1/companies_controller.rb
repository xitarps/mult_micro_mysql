class Api::V1::CompaniesController < Api::V1::ApplicationController
  before_action :fetch_company, only: :show

  def index
    if params[:per_page].nil? || params[:page].nil?
      return render json: { message: 'Please provide \'page:integer\' and \'per_page:integer\'' }, status: :bad_request
    end

    @companies = Company.offset(params[:page] * params[:per_page]).limit(params[:per_page])
  end

  def show; end

  def create
    @company = Company.new(company_params)
    return render :show if @company.save

    render json: @company.errors, status: :unprocessable_entity
  end

  def search
    if params[:search_term].nil?
      return render json: { message: 'Please provide \'search_term:string\'' }, status: :bad_request
    end

    return render json: { message: 'Please provide \'limit:string\'' }, status: :bad_request if params[:limit].nil?

    @companies = Company.where('name ILIKe ?', "%#{params[:search_term]}%").limit(params[:limit])
  end

  private

  def fetch_company
    @company = Company.find_by(id: params[:id])
    head :no_content if @company.nil?
  end

  def company_params
    params.require(:company).permit(:name)
  end
end
