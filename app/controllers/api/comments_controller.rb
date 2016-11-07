class Api::CommentsController < Api::BaseController
	before_action :get_comment, except: [ :create, :index]
	before_action :set_current_user
	skip_before_filter :verify_authenticity_token, :only => [:create, :show, :destroy]

	# /api/comments/:id			
	def show
		render json: {status: 0, data: comment}
	end

	# comment - /api/comments
	def create
    	post = Post.find(params[:post_id])
        comment = post.comments.build(:user_id => current_user.id, :description => params[:comment][:description])

		if comment.save
			render json: { status: 0, data: comment }
		else
			render json: { status: 2, messages: comment.errors.first.full_message }
		end
	end

	# DELETE - /api/comments/:id
	def destroy
	end

	def index
		post = Post.find(params[:post_id])
  		comments = post.comments
  		render json: { status: 0, data: comments }
	end

	private

	def comment_params
		params.require(:comment).permit(:description)
	end

	def comment_update_params
		params.require(:comment).permit(:description)
	end

	def get_comment
		@comment = Comment.find(params[:id])

	rescue ActiveRecord::RecordNotFound
		render json:{status: 2, messages: "Not Found"}
		
	end

	def set_current_user
		Comment.current_user = current_user
	end
end
