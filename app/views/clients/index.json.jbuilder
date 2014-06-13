json.array!(@clients) do |client|
  json.extract! client, :id, :nombre, :direccion, :telefono, :email
  json.url client_url(client, format: :json)
end
