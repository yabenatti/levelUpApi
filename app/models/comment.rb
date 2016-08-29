class Comment < ApplicationRecord
	belongs_to :user

	validate_presence_of :description
	validate_presence_of :user
end
