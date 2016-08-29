class AuthenticationToken < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user
  validates_presence_of :platform
  validates :authentication_token, presence: true, uniqueness: { scope: [:user_id, :platform] }
end