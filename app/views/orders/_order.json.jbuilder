json.extract! order, :id, :order_date, :customer_id, :address_id, :created_at, :updated_at
json.url order_url(order, format: :json)
