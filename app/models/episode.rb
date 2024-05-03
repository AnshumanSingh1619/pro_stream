class Episode < ApplicationRecord
  belongs_to :season
  has_one_attached :episode

  validates :episode_no, presence: true
end
