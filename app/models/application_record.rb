class ApplicationRecord < ActiveRecord::Base
	self.abstract_class = true
	mount_uploader :avatar, AvatarUploader
end
