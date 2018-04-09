json.array!(@designations) do |designation|
  json.extract! designation, :id, :name, :default
  json.url designation_url(designation, format: :json)
end
