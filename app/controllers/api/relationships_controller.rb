class Api::RelationshipsController < Api::BaseController

  def create
    user = User.find(params[:user_id])
    current_user.follow!(user)
    render json: { status: 0, message: nil }, status: :ok
  end

  def destroy
    user = User.find(params[:user_id])
    current_user.unfollow!(user)
    render json: { status: 0, message: nil }, status: :ok
  end
end
