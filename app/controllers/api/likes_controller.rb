class Api::LikesController <  Api::BaseController
	skip_before_filter :verify_authenticity_token, :only => [:create, :show, :destroy]

	def create
        post = Post.find(params[:post_id])

        if !current_user.likes?(post)
        	like = post.likes.build(:user => current_user)
        	like.save!
        	render json: { status: 0, message: nil, likes: post.likes.count }, status: :ok
        else
          	render json: { status: 3, message: t('post.already_liked'), likes: post.likes.count }, status: :internal_server_error
        end

    end

    def destroy
        post = Post.find(params[:post_id])
        like = Like.find_by(user: current_user, post: post)

        if like.destroy
            render json: {status: 0, data: nil}
        else 
            render json: {status: 3, message: "NOPE"}
        end
    end

    def index
  		likes = Like.all
  		render json: { status: 0, data: likes }
	end
end
