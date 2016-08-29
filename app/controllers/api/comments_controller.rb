class Api::CommentsController < Api::BaseController
	before_action :get_comment, except: [ :create]

	# /api/comments/:id			
	def show
		render json: {status : 0, data @comment}
	end

	# comment - /api/comments
	def create
		comment = Comment.new(comment_params)

		if comment.save
			render json: { status: 0, data: comment }
		else
			render json: { status: 2, messages: comment.errros.first.full_message }
		end
	end

	# PATCH - /api/comments/:id
	def update
		if @comment.update_attributes(comment_update_params)
			render json: { status: 0, data: @comment }
		else
			render json: { status: 2, messages: @comment.errros.first.full_message }
		end
	end

	# DELETE - /api/comments/:id
	def destroy
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
end
