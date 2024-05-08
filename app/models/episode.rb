class Episode < ApplicationRecord
  belongs_to :season
  mount_uploader :episode, VideoUploader

  validates :episode_no, presence: true
end
