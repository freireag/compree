require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  context "on GET to :index" do
    setup { get :index }

    should_render_template :index
    should_respond_with :success
    should_route :get, "/products", :action => :index
    
    should_not_set_the_flash
  end
  
  context "on GET to :show" do
    setup { get :show, :id => 1 }
    
    should_render_template :show
    should_respond_with :success
    should_route :get, "/products/show/1", :action => :show, :id => 1

    should_not_set_the_flash
  end
end
