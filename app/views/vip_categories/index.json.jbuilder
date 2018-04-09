json.array!(@vip_categories) do |vip_category|
  json.extract! vip_category, :id
  json.url vip_category_url(vip_category, format: :json)
end
