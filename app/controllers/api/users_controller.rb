	class Api::UsersController < Api::BaseController
	before_action :get_user, except: [ :create, :my_posts ]

	# /api/users/:id
	def show
		render json: { status: 0, data: @user }
	end

	# POST - /api/users
	def create
		user = User.new(user_params)

		if user.save
			render json: { status: 0, data: user }
		else
			render json: { status: 2, messages: user.errros.first.full_message }
		end
	end

	# PATCH - /api/users/:id
	def update
		if @user.update_attributes(user_update_params)
			render json: { status: 0, data: @user }
		else
			render json: { status: 2, messages: @user.errros.first.full_message }
		end
	end

	# DELETE - /api/users/:id
	def destroy
	end

	private

	#to create
	def user_params
		params.require(:user).permit(:name, :email, :birth_date, :pet_name, :password)
	end

	#allowed to update
	def user_update_params
		params.require(:user).permit(:name)
	end

	def get_user
		@user = User.find(params[:id])

	rescue ActiveRecord::RecordNotFound
		render json: { status: 2, messages: "Not found" }
	end

end