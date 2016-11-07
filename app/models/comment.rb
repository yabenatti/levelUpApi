class Comment < ApplicationRecord
	belongs_to :post
	belongs_to :user

	validates_presence_of :description
	validates :user_id, presence: true
  	validates :post_id, presence: true

  	attr_accessor :current_user

	def as_json(options)
		super(methods: [:pet_name])		
	end

	def pet_name
		self.user.pet_name
	end

  	def self.current_user=(user)
		@current_user = user
	end

	def self.current_user
		@current_user
	end

end
