require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_it_exists
    @item_1 = Item.new({
          :id          => 263395237,
          :name        => "Pencil",
          :description => "You can use it to write things",
          :unit_price  => BigDecimal.new(10.99,4),
          :merchant_id => 12334141,
          :created_at  => Time.now,
          :updated_at  => Time.now
      })
    @item_2 = Item.new({
          :id          => 263395985,
          :name        => "Marker",
          :description => "You can use it to write more things",
          :unit_price  => BigDecimal.new(12.99,4),
          :merchant_id => 12339191,
          :created_at  => Time.now,
          :updated_at  => Time.now
      })
    @item_3 = Item.new({
          :id          => 263395234,
          :name        => "Chapstick",
          :description => "Moisturizes lips.",
          :unit_price  => BigDecimal.new(4.55,4),
          :merchant_id => 12337777,
          :created_at  => Time.now,
          :updated_at  => Time.now
      })
    @items = [@item_1, @item_2, @item_3]

    @merchant_1 = Merchant.new({:id => 5, :name => "Turing School"})
    @merchant_2 = Merchant.new({:id => 7, :name => "G School"})
    @merchant_3 = Merchant.new({:id => 15, :name => "Denver University"})
    @merchants = [@merchant_1, @merchant_2, @merchant_3]

    @sales_engine = SalesEngine.new(@items, @merchants)

    assert_instance_of SalesEngine, @sales_engine
  end

  def test_factory_method_creates_instance
    sales_engine = SalesEngine.from_csv({
          :items     => "./data/items.csv",
          :merchants => "./data/merchants.csv",
          })

    assert_instance_of SalesEngine, sales_engine
  end

  def test_it_creates_merchant_repository_object
    sales_engine = SalesEngine.from_csv({
          :items     => "./data/items.csv",
          :merchants => "./data/merchants.csv",
          })

    assert_instance_of MerchantRepository, sales_engine.merchants
  end

  def test_it_creates_item_repository_object
    sales_engine = SalesEngine.from_csv({
          :items     => "./data/items.csv",
          :merchants => "./data/merchants.csv",
          })

    assert_instance_of ItemRepository, sales_engine.items
  end

  def test_it_creates_new_sales_analyst
    sales_engine = SalesEngine.from_csv({
          :items     => "./data/items.csv",
          :merchants => "./data/merchants.csv",
          })
    sales_analyst = sales_engine.analyst

    assert_instance_of SalesAnalyst, sales_analyst
  end
end
