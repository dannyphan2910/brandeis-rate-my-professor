json.extract! review, :id, :user_id, :title, :rate_up, :rate_down, :created_at, :updated_at
json.url review_url(review, format: :json)
