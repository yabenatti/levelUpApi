class Post < ApplicationRecord
	belongs_to :user
	has_many :comments
	has_many :likes, dependent: :destroy
	mount_uploader :image, PostImageUploader


	# validate_presence_of :description
end
