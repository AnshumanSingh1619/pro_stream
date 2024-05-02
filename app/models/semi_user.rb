class SemiUser < ApplicationRecord
  belongs_to :user
  has_one_attached :profile_pic
  validates :name, :age, presence: true
end
