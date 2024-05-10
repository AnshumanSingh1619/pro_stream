class SemiUser < ApplicationRecord
  belongs_to :user
  has_one_attached :profile_pic
  validates :name, :date_of_birth, presence: true
  before_create :calculate_age
  has_many :my_lists, dependent: :destroy


  private

  def calculate_age
    if date_of_birth.present?
      now = Time.zone.now.to_date
      self.age = now.year - date_of_birth.year 
    end
  end
end
