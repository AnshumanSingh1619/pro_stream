class Content < ApplicationRecord
  has_many :seasons, dependent: :destroy, inverse_of: :content
  accepts_nested_attributes_for :seasons, allow_destroy: true, reject_if: :all_blank
  has_one_attached :trailer
  has_one_attached :movie
  has_one_attached :poster
end
