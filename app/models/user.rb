class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  def jwt_payload
    super
  end       
  before_validation :calculate_age
  validates :firstname, :lastname, :date_of_birth, :gender, presence: true
  has_many :semi_users, dependent: :destroy

  after_create do 
    stripe_customer = Stripe::Customer.create(
      email: email,
      name: "#{firstname} #{lastname}"
      )
    update(subscription_ends_at: Time.now - 1.day, stripe_customer_id: stripe_customer.id)
  end     

  private

  def calculate_age
    now = Time.zone.now.to_date
    self.age = now.year - date_of_birth.year
  end
end
