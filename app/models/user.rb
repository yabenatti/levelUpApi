require 'bcrypt'

class User < ApplicationRecord
	include BCrypt
	include TokenHelper

	has_one :beacon, dependent: :destroy
	has_many :posts, dependent: :destroy
	# has_many :comments, dependent: :destroy
	has_many :authentication_tokens, dependent: :destroy

	has_many :likes, dependent: :destroy
  	has_many :liked_posts, through: :likes, source: :post, dependent: :destroy

	validates_presence_of :email

	has_secure_password

	validates_format_of :email, :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

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

end
