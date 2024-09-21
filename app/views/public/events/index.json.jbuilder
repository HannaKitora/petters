json.data do
  json.items do
    json.array!(@events) do |event|
      json.id event.id
      json.image url_for(event.image)
      json.title event.title
      json.detail event.detail
      json.event_address event.event_address
      json.latitude event.latitude
      json.longitude event.longitude
    end  
  end
end