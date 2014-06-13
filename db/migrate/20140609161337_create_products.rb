class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :codigo
      t.string :nombre
      t.integer :stock
      t.float :precio

      t.timestamps
    end
  end
end
