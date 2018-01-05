require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
      items:     './test/fixtures/items_truncated.csv',
      merchants: './test/fixtures/merchants_truncated.csv'
    })
  end

  def test_creates_instance_of_item_repository
    assert_instance_of ItemRepository, @se.items
  end

  def test_creates_instance_of_merchant_repository
    assert_instance_of MerchantRepository, @se.merchants
  end

  def test_it_calls_item_repository_to_return_items_by_merchant_id
    result = @se.find_items_by_merchant_id(12334113)

    all_merchant_items =  result.all? do |item|
      item.merchant_id == 12334113
    end

    assert all_merchant_items
  end

  def test_it_calls_merchant_repository_to_return_merchant_by_merchant_id
    merchant_id = 12334113

    result = @se.find_merchant_by_merchant_id(merchant_id)

    assert result.id, merchant_id
    assert_instance_of Merchant, result
  end
end
