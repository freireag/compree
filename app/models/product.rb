class Product < ActiveRecord::Base
  validates_numericality_of :price, :greater_than => 0
  validates_numericality_of :quantity, :greater_than_or_equal_to => 0, :only_integer => true
  
  validates_presence_of :name
  validates_presence_of :price
  validates_presence_of :quantity
  
  validates_uniqueness_of :name
end
