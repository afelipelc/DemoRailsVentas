json.array!(@sales) do |sale|
  json.extract! sale, :id, :client_id, :fecha, :importe
  json.url sale_url(sale, format: :json)
end
