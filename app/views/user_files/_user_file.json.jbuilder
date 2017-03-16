json.extract! user_file, :id, :user_id, :name, :content, :orig, :created_at, :updated_at
json.url user_file_url(user_file, format: :json)
