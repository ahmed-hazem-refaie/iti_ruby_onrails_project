json.extract! notification, :id, :body, :user_id, :order_id, :type, :created_at, :updated_at
json.url notification_url(notification, format: :json)
