require 'bcrypt'

class User < ApplicationRecord
	include BCrypt
	include TokenHelper

	has_one :beacon, dependent: :destroy
	has_many :posts, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :authentication_tokens, dependent: :destroy

	validates_presence_of :email

	has_secure_password

	validates_format_of :email, :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

	# def as_json(options)
	# 	super(except: [:password_digest, :created_at, :updated_at])
	# end

end
