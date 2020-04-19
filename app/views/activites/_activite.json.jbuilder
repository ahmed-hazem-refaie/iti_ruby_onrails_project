json.extract! activite, :id, :action, :user_id, :created_at, :updated_at
json.url activite_url(activite, format: :json)
