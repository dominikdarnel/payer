json.extract! transaction, :id, :amount, :initiated_by_id, :from_account_id, :to_account_id, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
