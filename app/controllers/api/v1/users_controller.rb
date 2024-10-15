class Api::V1::UsersController < Api::V1::ApplicationController
  def index
    if params[:per_page].nil? || params[:page].nil?
      return render json: { message: 'Please provide \'page:integer\' and \'per_page:integer\'' }, status: :bad_request
    end

    return render json: { message: 'Please provide \'company_id:integer\'' }, status: :bad_request if params[:company_id].nil?

    @users = User.where(company_id: params[:company_id])
                 .offset(params[:page] * params[:per_page])
                 .limit(params[:per_page])
  end

  def create
    @user = user.new(user_params)
    return render :show if @user.save

    render json: @user.errors, status: :unprocessable_entity
  end

  def destroy
    fetch_user
    return render json: {}, status: :ok if @user.destroy

    render json: {}, status: :unprocessable_entity
  end

  def joins_leader
    return render json: { message: 'Please provide \'leader_id:integer\'' }, status: :bad_request if params[:leader_id].nil?
    return render json: { message: 'Please provide \'user_id:integer\'' }, status: :bad_request if params[:user_id].nil?

    @leader = User.find(params[:leader_id])
    @user = User.find(params[:user_id])

    return render json {}, status: :unprocessable_entity if @leader.nil? || @user.nil?

    Users::JoinsLeaderService.call(user: @user, leader_id: @leader)
    render json: {}, status: :ok
  end

  def managed_users
    return render json: { message: 'Please provide \'leader_id:integer\'' }, status: :bad_request if params[:leader_id].nil?

    @leader = User.find(params[:leader_id])
    @users = @leader.managed_users
  end

  def sub_managed_users
    return render json: { message: 'Please provide \'leader_id:integer\'' }, status: :bad_request if params[:leader_id].nil?

    @leader = User.find(params[:leader_id])
    @users = Users::FetchSubManagedUsersService.call(leader_id: @leader.id)
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end

  def fetch_user
    @user = User.find(params[:id])
  end
end
