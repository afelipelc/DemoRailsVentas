class SaleDetail < ActiveRecord::Base
	belongs_to :product
	belongs_to :venta
end
