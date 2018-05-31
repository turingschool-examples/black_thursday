require_relative 'test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def setup
    @file_paths = {:items     => './data/items.csv',
                  :merchants => './data/merchants.csv'}
    @se = SalesEngine.new(@file_paths)
  end

  def test_it_exists
    assert_instance_of SalesEngine, @se
  end

  def test_it_can_load_the_file
    assert_instance_of MerchantRepository, @se.merchants
    assert_instance_of ItemRepository, @se.items
    assert_instance_of SalesAnalyst, @se.analyst
  end
end
