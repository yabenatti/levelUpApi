class Comment < ApplicationRecord
	belongs_to :user
	belongs_to :post

	validate_presence_of :description
	validate_presence_of :user
end
