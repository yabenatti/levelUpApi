require 'bcrypt'

class User < ApplicationRecord
	include BCrypt
	include TokenHelper

	has_one :beacon
	has_many :posts
	has_many :comments
	has_many :authentication_tokens

	validates_presence_of :email
	validates_presence_of :name

	has_secure_password

	validates_format_of :email, :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

	def as_json(options)
		super(except: [:password_digest, :created_at, :updated_at])
	end

end
