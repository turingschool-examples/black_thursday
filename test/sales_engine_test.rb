require './lib/sales_engine'
require 'csv'
require 'minitest/autorun'
require 'minitest/emoji'

class SalesEngineTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
          :items     => "./data/items.csv",
          :merchants => "./data/merchants.csv",
          })
  end

  def test_it_exists
    assert_instance_of SalesEngine, @se
  end

  def test_it_has_an_item_repository
    assert_instance_of ItemRepository, @se.item
  end

  def test_it_has_a_merchant_repository
    assert_instance_of MerchantRepository, @se.merchant
  end

end
