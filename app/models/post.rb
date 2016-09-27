class Post < ApplicationRecord
	belongs_to :user
	has_many :comments

	# validate_presence_of :description
end
