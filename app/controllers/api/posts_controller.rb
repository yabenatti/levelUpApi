class Api::PostsController < Api::BaseController
	before_action :get_post, except: [ :create]
	skip_before_filter :verify_authenticity_token, :only => [:create, :show, :destroy]

	# /api/posts/:id			
	def show
		render json: { status: 0, data: @post }
	end

	# POST - /api/posts
	def create
		post = current_user.posts.build(post_params)

		if post.save
			render json: { status: 0, data: post }
		else
			render json: { status: 2, messages: post.errros.first.full_message }
		end
	end

	# PATCH - /api/posts/:id
	def update
		if @post.update_attributes(post_update_params)
			render json: { status: 0, data: @post }
		else
			render json: { status: 2, messages: @post.errros.first.full_message }
		end
	end

	# DELETE - /api/posts/:id
	def destroy
	end

	def my_posts
		render json: { status: 0, data: current_user.posts }, status: :ok
	end

	private

	def post_params
		params.require(:post).permit(:description, :image)
	end

	def post_update_params
		params.require(:post).permit(:description)
	end

	def get_post
		@post = Post.find(params[:id])

	rescue ActiveRecord::RecordNotFound
		render json:{status: 2, messages: "Not Found"}
		
	end
end
