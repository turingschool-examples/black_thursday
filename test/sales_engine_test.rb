require_relative 'test_helper.rb'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_it_exists
    se = SalesEngine.new

    assert_instance_of SalesEngine, se
  end

  def test_item_instance_created
    se = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        })
    assert_instance_of ItemRepository, se.items
  end

  def test_merchant_instance_created
    se = SalesEngine.from_csv({
      :merchants     => "./data/merchants.csv",
      })
      assert_instance_of MerchantRepository, se.merchants
  end

end
