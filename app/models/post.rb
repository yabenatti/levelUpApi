class Post < ApplicationRecord
	belongs_to :user
	has_many :comments
	has_many :likes, dependent: :destroy
	mount_uploader :image, PostImageUploader

	attr_accessor :current_user


	# validate_presence_of :description

	def as_json(options)
		super(methods: [:pet_name, :pet_image, :liked])		
	end

	def pet_name
		self.user.pet_name
	end

	def pet_image
		self.user.beacon.pet_image
	end

	def liked
		like = Like.find_by(post: self, user: Post.current_user)
		like.present?
	end

	def self.current_user=(user)
		@current_user = user
	end

	def self.current_user
		@current_user
	end

end
