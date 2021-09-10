respond_to :json
rescue_from ActiveRecord::RecordNotFound, with: :not_found
protect_from_forgery with: :null_session

def not_found
    respond_with '{"error": "order_product_not_found"}', status: :not_found
end

def place_order

end