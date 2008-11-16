class AddColumnImageUrlToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :image_url, :string
  end

  def self.down
    remove_column :products, :image_url
  end
end
