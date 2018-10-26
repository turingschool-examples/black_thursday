require './test/test_helper'
require './lib/sales_engine'
require './lib/item_repository'
require './lib/merchant_repository'
require './lib/merchant'
require './lib/item'

class SalesEngineTest < Minitest::Test
  def test_it_exists
    mr = MerchantRepository.new
    ir = ItemRepository.new
    se = SalesEngine.new({merchants: mr, items: ir})
    assert_instance_of SalesEngine, se
  end

  def test_it_can_load_csv_files_items_and_merchants
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :transactions => "./data/transactions.csv"
    })
    assert_instance_of MerchantRepository, se.merchants
    assert_instance_of ItemRepository, se.items
    assert_instance_of InvoiceRepository, se.invoices
    assert_instance_of TransactionRepository, se.transactions
  end

  def test_it_can_load_merchants_correctly
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    merchant_1 = Merchant.new({id: 12334105, name: "Shopin1901"})
    merchant_2 = Merchant.new({id: 12334112, name: "Candisart"})
    assert_equal merchant_1.id, se.merchants.all[0].id
    assert_equal merchant_1.name, se.merchants.all[0].name
    assert_equal merchant_2.id, se.merchants.all[1].id
    assert_equal merchant_2.name, se.merchants.all[1].name
  end

  def test_it_can_load_items_correctly
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    item_1 = Item.new({
          :id          => 263395237,
          :name        => "510+ RealPush Icon Set",
          :description => "You&#39;ve got a...",
          :unit_price  => (BigDecimal.new(1200,4) / 100),
          :created_at  => Time.parse("2016-1-11 9:34:06 UTC"),
          :updated_at  => Time.parse("2016-1-11 9:34:06 UTC"),
          :merchant_id => 12334141
        })
    item_2 = Item.new({
          :id          => 263395617,
          :name        => "Glitter scrabble frames",
          :description => "Glitter scrabble frames...",
          :unit_price  => (BigDecimal.new(1300,4) / 100),
          :created_at  => Time.parse("2016-1-11 11:51:37 UTC"),
          :updated_at  => Time.parse("1993-9-29 11:56:40 UTC"),
          :merchant_id => 12334185
        })
    assert_equal item_1.id, se.items.all[0].id
    assert_equal item_1.name, se.items.all[0].name
    assert_equal item_1.description[0..10], se.items.all[0].description[0..10]
    assert_equal item_1.unit_price, se.items.all[0].unit_price
    assert_equal item_2.created_at, se.items.all[1].created_at
    assert_equal item_2.updated_at, se.items.all[1].updated_at
    assert_equal item_2.merchant_id, se.items.all[1].merchant_id
  end
  def test_it_can_create_analyst
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    sa = sales_engine.analyst
    assert_instance_of SalesAnalyst, sa
  end
end
