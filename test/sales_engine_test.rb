require './test/test_helper'
require './lib/sales_engine'
require './lib/file_loader'
# require './lib/merchant_repository'

class SalesEngineTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
      :items     => './data/items.csv',
      :merchants => './data/merchants.csv',
      })
  end

  def test_it_exists
    assert_instance_of SalesEngine, @se
  end

  def test_it_can_find_a_merchant_by_name
    mr = @se.merchants
    merchant = mr.find_by_name('CJsDecor')

    assert_instance_of Merchant, merchant
    assert_equal 'CJsDecor', merchant.name
  end

  def test_it_can_find_an_item_by_name
    skip
    ir = @se.items
    item = ir.find_by_name('Item Repellat Dolorum')

    assert_instance_of Item, item
    assert_equal 'Item Repellat Dolorum', item.name
  end

  def test_it_creates_analyst
    result = @se.analyst
    assert_instance_of SalesAnalyst, result
  end
end
