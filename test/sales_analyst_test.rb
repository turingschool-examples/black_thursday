require './test/test_helper'
require './lib/sales_engine'
require './lib/item'
require './lib/item_repository'

class SalesAnalystTest < Minitest::Test

  def setup
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    @sa = sales_engine.analyst
    @item_1 = Item.new({
          :id          => 263397059,
          :name        => "Pencil",
          :description => "You can use it to write things",
          :unit_price  => (BigDecimal.new(10.99,4) / 100),
          :created_at  => "2016-01-11 12:29:33 UTC",
          :updated_at  => "1993-08-29 22:53:20 UTC",
          :merchant_id => 213567
        })
    @item_2 = Item.new({
          :id          => 2347892358,
          :name        => "Marker",
          :description => "You can use it to mark things",
          :unit_price  => (BigDecimal.new(12.50,4) / 100),
          :created_at  => "2016-01-11 12:02:55 UTC",
          :updated_at  => "1973-05-29 23:44:48 UTC",
          :merchant_id => 983406
        })
    @item_3 = Item.new({
          :id          => 2413,
          :name        => "Jump rope",
          :description => "Jump it",
          :unit_price  => (BigDecimal.new(24.50,4) / 100),
          :created_at  => "2016-01-11 12:02:55 UTC",
          :updated_at  => "1973-05-29 23:44:48 UTC",
          :merchant_id => 245
        })
    @item_4 = Item.new({
          :id          => 6432,
          :name        => "Elf costume",
          :description => "Be santa's little helper.",
          :unit_price  => (BigDecimal.new(30.65,4) / 100),
          :created_at  => "2016-01-11 12:05:55 UTC",
          :updated_at  => "1973-05-29 23:44:48 UTC",
          :merchant_id => 24524
        })
    @ir = ItemRepository.new
    @ir.add_item(@item_1)
    @ir.add_item(@item_2)
    @ir.add_item(@item_3)
    @ir.add_item(@item_4)
  end

  def test_average_items_per_merchant
    assert_equal 2.88 , @sa.average_items_per_merchant
  end

  def test_it_can_find_average_items_per_merchant_standard_deviation
    skip
    assert_equal 3.26, @sa.std_dev_ave
  end

  def test_it_can_find_average_price_of_items
    sa = SalesAnalyst.new(items: @ir)
    assert_equal 0.20, sa.average_price_of_items
  end

  def test_it_can_find_golden_items
    item_5 = Item.new({
          :id          => 64423432,
          :name        => "Elf costume",
          :description => "Be santa's little helper.",
          :unit_price  => (BigDecimal.new(300.65,4) / 100),
          :created_at  => "2016-01-11 12:05:55 UTC",
          :updated_at  => "1973-05-29 23:44:48 UTC",
          :merchant_id => 24524
        })
    item_6 = Item.new({
          :id          => 643243352,
          :name        => "Elf costume",
          :description => "Be santa's little helper.",
          :unit_price  => (BigDecimal.new(3.65,4) / 100),
          :created_at  => "2016-01-11 12:05:55 UTC",
          :updated_at  => "1973-05-29 23:44:48 UTC",
          :merchant_id => 24524
        })
    item_7 = Item.new({
          :id          => 6423532,
          :name        => "Elf costume",
          :description => "Be santa's little helper.",
          :unit_price  => (BigDecimal.new(3.65,4) / 100),
          :created_at  => "2016-01-11 12:05:55 UTC",
          :updated_at  => "1973-05-29 23:44:48 UTC",
          :merchant_id => 24524
        })
    @ir.add_item(item_5)
    @ir.add_item(item_6)
    @ir.add_item(item_7)
    sa = SalesAnalyst.new(items: @ir)
    assert_equal [item_5], sa.golden_items
  end

  def test_merchants_with_high_item_count
    assert_equal 52, @sa.merchants_with_high_item_count.length
  end

  def test_avg_avg_per_merchant
    assert_equal 350.29, @sa.average_average_price_per_merchant
    assert_instance_of BigDecimal, @sa.average_average_price_per_merchant
  end

  def test_mini_avg_avg_per_merchant
    item_5 = Item.new({
          :id          => 64423432,
          :name        => "Elf costume",
          :description => "Be santa's little helper.",
          :unit_price  => (BigDecimal.new(300.65,4) / 100),
          :created_at  => "2016-01-11 12:05:55 UTC",
          :updated_at  => "1973-05-29 23:44:48 UTC",
          :merchant_id => 24524
        })
    item_6 = Item.new({
          :id          => 643243352,
          :name        => "Elf costume",
          :description => "Be santa's little helper.",
          :unit_price  => (BigDecimal.new(3.65,4) / 100),
          :created_at  => "2016-01-11 12:05:55 UTC",
          :updated_at  => "1973-05-29 23:44:48 UTC",
          :merchant_id => 24524
        })
    item_7 = Item.new({
          :id          => 6423532,
          :name        => "Elf costume",
          :description => "Be santa's little helper.",
          :unit_price  => (BigDecimal.new(3.65,4) / 100),
          :created_at  => "2016-01-11 12:05:55 UTC",
          :updated_at  => "1973-05-29 23:44:48 UTC",
          :merchant_id => 24524
        })
    @ir.add_item(item_5)
    @ir.add_item(item_6)
    @ir.add_item(item_7)
    sa = SalesAnalyst.new(items: @ir)
    assert_equal 0.33, sa.average_average_price_per_merchant
  end

  def test_it_can_find_average_items_per_merchant_std_dev
    assert_equal 3.26, @sa.average_items_per_merchant_standard_deviation
    assert_instance_of Float, @sa.average_items_per_merchant_standard_deviation
  end
end
