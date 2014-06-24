class ChangeImporteFormatInSales < ActiveRecord::Migration
  def change
  	change_column :sales, :importe, :float
  end
end
