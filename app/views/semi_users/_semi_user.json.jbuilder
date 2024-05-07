json.extract! semi_user, :id, :name, :age, :user_id, :profile_pic, :date_of_birth, :created_at, :updated_at
json.url semi_user_url(semi_user, format: :json)
