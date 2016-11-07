require 'bcrypt'

class User < ApplicationRecord
	include BCrypt
	include TokenHelper

	has_one :beacon, dependent: :destroy
	has_many :posts, dependent: :destroy
	# has_many :comments, dependent: :destroy
	has_many :authentication_tokens, dependent: :destroy
	has_many :active_relationships,   class_name: "Relationship",
	                                foreign_key: "follower_id",
	                                dependent: :destroy
	has_many :passive_relationships,  class_name: "Relationship",
	                                foreign_key: "followed_id",
	                                dependent: :destroy
	has_many :following, through: :active_relationships, source: :followed, dependent: :destroy
	has_many :followers, through: :passive_relationships, source: :follower, dependent: :destroy

	has_many :likes, dependent: :destroy
  	has_many :liked_posts, through: :likes, source: :post, dependent: :destroy

	validates_presence_of :email

	has_secure_password

	validates_format_of :email, :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/


	def as_json(options=nil)
		super(methods: [:pet_image])		
	end

	def pet_image
		if(self.beacon.present?)
			self.beacon.pet_image
		end
	end

	  # Curte um post.
	def like!(post)
	likes.create!(post_id: post.id)
	end

	# Retorna verdadeiro se o curte um determinado post e falso caso contrário.
	def likes?(post)
	liked_posts.include?(post)
	end

	# def as_json(options)
	# 	super(except: [:password_digest, :created_at, :updated_at])
	# end
	# Segue o usuário.
	def follow!(other_user)
		active_relationships.create!(followed_id: other_user.id)
	end

	# Deixa de seguir o usuário.
	def unfollow!(other_user)
		active_relationships.find_by(followed_id: other_user.id).destroy
	end

	# Retorna verdadeiro se o usuário em questão está seguindo o outro usuário.
	def following?(other_user)
		following.include?(other_user)
	end
end
