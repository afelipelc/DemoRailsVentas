json.array!(@products) do |product|
  json.extract! product, :id, :codigo, :nombre, :stock, :precio
  json.url product_url(product, format: :json)
end
