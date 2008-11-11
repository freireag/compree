class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name, :null => false
      t.text :description
      t.decimal :price, :null => false, :scale => 2, :precision => 10
      t.integer :quantity, :null => false, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
