json.extract! question, :id, :question, :author, :country, :state, :created_at, :updated_at
json.url question_url(question, format: :json)
