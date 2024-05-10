class Admin < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  def jwt_payload
    super
  end     
  before_create :calculate_age

  private

  def calculate_age
    if date_of_birth.present?
      now = Time.zone.now.to_date
      self.age = now.year - date_of_birth.year
    end
  end
end
