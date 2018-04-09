json.array!(@offices) do |office|
  json.extract! office, :id, :name, :room_no, :floor, :incharge_name
  json.url office_url(office, format: :json)
end
