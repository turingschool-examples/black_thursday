require_relative 'test_helper'

require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
      items: './data/items.csv',
      merchants: './data/merchants.csv'})
  end

  def test_it_exists
    assert_instance_of SalesEngine, @se
  end

  def test_it_holds_an_item_repository
    assert_instance_of ItemRepository, @se.items
  end

  def test_it_holds_an_merchant_repository
    assert_instance_of MerchantRepository, @se.merchants
  end
end
