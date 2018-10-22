json.extract! card, :id, :bank, :name, :number, :month, :year, :ccv, :created_at, :updated_at
json.url card_url(card, format: :json)
