json.array!(@questions) do |question|
  json.extract! question, :id, :name, :mail_id, :ques
  json.url question_url(question, format: :json)
end
