json.array!(@handlers) do |handler|
  json.extract! handler, :id, :name, :room_no, :floor, :contact_no, :intercom
  json.url handler_url(handler, format: :json)
end
