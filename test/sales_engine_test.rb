require './test/test_helper'
require './lib/sales_engine'
require './lib/item_repository'
require './lib/merchant_repository'
require './lib/merchant'

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

  def test_it_can_load_merchants_correctly
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    merchant_1 = Merchant.new({id: 12334105, name: "Shopin1901"})
    merchant_2 = Merchant.new({id: 12334112, name: "Candisart"})
    assert_equal merchant_1.id, se.merchants[0].id
    assert_equal merchant_1.name, se.merchants[0].name
    assert_equal merchant_2.id, se.merchants[1].id
    assert_equal merchant_2.name, se.merchants[1].name
  end


end
