require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def setup
    @se = SalesEngine.new({ items:     './test/fixtures/items_truncated.csv',
                            merchants: './test/fixtures/merchants_truncated.csv'
                          })
  end

  def test_creates_instance_of_item_repository
    assert_instance_of ItemRepository, @se.items
  end

  def test_creates_instance_of_merchant_repository
    assert_instance_of MerchantRepository, @se.merchants
  end
end
