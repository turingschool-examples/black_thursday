require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_it_exists
    se = SalesEngine.new
    assert_instance_of SalesEngine, se
  end

  def test_it_can_load_csv_files_items_and_merchants
    se = SalesEngine.new.from_csv({
      # :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    binding.pry
    assert_instance_of MerchantRepository, se.merchants
    # assert_instance_of ItemRepository, se.items
  end
end
