require './test/test_helper'
require './lib/sales_engine'
require './lib/item_repository'
require './lib/merchant_repository'

class SalesEngineTest < Minitest::Test
  def test_it_exists
    mr = MerchantRepository.new
    ir = ItemRepository.new
    se = SalesEngine.new(mr, ir)
    assert_instance_of SalesEngine, se
  end

  def test_it_can_load_csv_files_items_and_merchants
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    assert_instance_of MerchantRepository, se.merchants
    assert_instance_of ItemRepository, se.items
  end

  
end
