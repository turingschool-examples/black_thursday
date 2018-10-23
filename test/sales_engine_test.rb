require_relative 'test_helper'
require 'pry'


class SalesEngineTest < Minitest::Test
  def setup
    @se = SalesEngine.new({ 
      :items => "./data/items.csv", 
      :merchants => "./data/merchants.csv",
    })
  end
  
  def test_it_can_exists
    assert_instance_of SalesEngine, @se
  end

  def test_it_has_items_csv_data
    
  end

  def test_it_has_merchant_csv_data
    
  end

  def test_it_can_create_a_merchant_repository
    
  end
end
