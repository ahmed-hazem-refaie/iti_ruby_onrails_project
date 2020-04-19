json.extract! orderdetail, :id, :item, :amount, :price, :comment, :user_id, :order_id, :created_at, :updated_at
json.url orderdetail_url(orderdetail, format: :json)
