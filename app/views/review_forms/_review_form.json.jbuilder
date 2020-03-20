json.extract! review_form, :id, :review, :created_at, :updated_at
json.url review_form_url(review_form, format: :json)
