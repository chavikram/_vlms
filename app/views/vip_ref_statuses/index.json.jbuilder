json.array!(@vip_ref_statuses) do |vip_ref_status|
  json.extract! vip_ref_status, :id
  json.url vip_ref_status_url(vip_ref_status, format: :json)
end
