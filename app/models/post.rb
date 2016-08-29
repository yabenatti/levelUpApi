class Post < ApplicationRecord
	belongs_to :user

	validate_presence_of :description
end
