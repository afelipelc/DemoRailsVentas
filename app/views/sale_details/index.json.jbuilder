json.array!(@sale_details) do |sale_detail|
  json.extract! sale_detail, :id, :sale_id, :product_id, :preciounitario, :cantidad, :importe
  json.url sale_detail_url(sale_detail, format: :json)
end
