class Api::SessionsController < Api::BaseController
	skip_before_filter :authenticate!, only: [:create]

	def create
		user = User.find_by(email: params[:email])

		if user && user.authenticate(params[:password])
			token = user.create_and_return_token
			user = user.as_json
			user[:authentication_token] = token

			render json: { status: 0, data: user }, status: :ok
		else
			render json: { status: 3, messages: "Authentication Failed" }, status: :forbbiden
		end

	rescue ActiveRecord::RecordNotFound
		render json: { status: 2, messages: "User not found" }, status: :not_found
	end

	def destroy
		# TODO - Setar token para nulo
	end

end
