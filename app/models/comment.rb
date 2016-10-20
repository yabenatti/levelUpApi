class Comment < ApplicationRecord
	belongs_to :post
	belongs_to :user

	validates_presence_of :description
	validates :user_id, presence: true
  	validates :post_id, presence: true

end
