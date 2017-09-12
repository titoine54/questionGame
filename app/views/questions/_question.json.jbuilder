json.extract! question, :id, :question, :author_string, :created_at, :updated_at
json.url question_url(question, format: :json)
