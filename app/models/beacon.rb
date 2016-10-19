class Beacon < ApplicationRecord
	belongs_to :user
	mount_uploader :pet_image, AvatarUploader

end
