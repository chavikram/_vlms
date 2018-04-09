json.array!(@complaints) do |complaint|
  json.extract! complaint, :id, :complaint_type_id, :remarks, :location, :date_since, :user_id
  json.url complaint_url(complaint, format: :json)
end
