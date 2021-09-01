json.extract! wallet, :id, :amount, :pin, :customer_id, :created_at, :updated_at
json.url wallet_url(wallet, format: :json)
