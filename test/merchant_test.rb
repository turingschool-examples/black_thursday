require_relative 'test_helper'
require './lib/sales_engine'

class MerchantTest < Minitest::Test

  def setup
    item_file_path = './test/fixtures/items_truncated.csv'
    merchant_file_path = './test/fixtures/merchants_truncated.csv'
    engine = SalesEngine.new(item_file_path, merchant_file_path)
    merchant_repo = engine.merchants
    @merchants = merchant_repo.merchants
  end

  def test_class_merchant_exists
    merchant = @merchants[0]

    assert_instance_of Merchant, merchant
  end

  def test_it_initializes_with_id_and_name_and_sales_engine
    merchant = @merchants[0]

    assert_equal '12334112', merchant.id
    assert_equal "Candisart", merchant.name
    assert_instance_of SalesEngine, merchant.engine
  end

  def test_items_returns_all_merchant_id_items_in_one_array
    merchant = @merchants[-1]

    assert_equal 3, merchant.items.count
  end

end
