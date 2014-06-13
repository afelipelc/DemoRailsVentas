class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.integer :client_id
      t.datetime :fecha
      t.datetime :importe

      t.timestamps
    end
  end
end
