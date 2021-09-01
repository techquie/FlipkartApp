json.extract! product, :id, :name, :price, :description, :quantity, :category_id, :seller_id, :created_at, :updated_at
json.url product_url(product, format: :json)
