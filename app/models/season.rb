class Season < ApplicationRecord
  belongs_to :content
  has_many :episodes, dependent: :destroy, inverse_of: :season
  accepts_nested_attributes_for :episodes, allow_destroy: true, reject_if: :all_blank

  validates :season_no, presence: true
end
