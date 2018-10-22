json.extract! account, :id, :currency, :amount, :user_id, :created_at, :updated_at
json.url account_url(account, format: :json)
