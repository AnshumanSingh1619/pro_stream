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


#.alert{
#  position: absolute;
#  left: 750px;
#  top: 0px;
#}
#</style>
#<% if alert.present? %>
#<div class="max-w-sm p-6 alert bg-white border border-gray-200 rounded-lg shadow dark:bg-gray-800 dark:border-gray-700">
#<a href="#">
#  <h5 class="mb-2 text-2xl font-bold tracking-tight text-gray-900 dark:text-white"><%= alert %></h5>
#</a>
#</div>
#<% end %>
