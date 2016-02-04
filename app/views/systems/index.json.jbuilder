json.array!(@systems) do |system|
  json.extract! system, :id, :name, :contact_name, :contact_email, :permalink
  json.url system_url(system, format: :json)
end
