require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  context "given an existing record" do
    fixtures :all
    
    should_have_db_columns :id, :name, :description, :price, :quantity
    should_have_db_column :name, :type => "string", :null => false
    should_have_db_column :price, :type => "decimal", :null => false, :scale => 2
    should_have_db_column :quantity, :type => "integer", :default => 0, :null => false

    should_have_instance_methods :name, :name=, :description, :description=, :price, :price=, :quantity, :quantity=

    should_not_allow_values_for :price, -1, 0, :message => "must be greater than 0"
    should_not_allow_values_for :quantity, -1, :message => "must be greater than or equal to 0"
    should_not_allow_values_for :quantity, 1.3, :message => "is not a number"
    should_allow_values_for :quantity, 0

    should_only_allow_numeric_values_for :price
    should_only_allow_numeric_values_for :quantity

    should_require_attributes :name, :price, :quantity
    should_require_unique_attributes :name
  end
end