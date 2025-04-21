class Team < ApplicationRecord
  mount_uploader :picture, PictureUploader
end
