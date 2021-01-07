require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/sales_analyst'
require './lib/sales_engine'
require './lib/merchant'
require './lib/merchant_repository.rb'
require './lib/item_repository'
require './lib/item'
require 'pry'

class SalesAnalystTest < Minitest::Test
  def test_it_exists_and_has_attributes
    engine = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
        })
    analyst = SalesAnalyst.new(engine)

    assert_instance_of SalesAnalyst, analyst
    assert_instance_of SalesEngine, analyst.engine
  end

  def test_it_can_find_all
    engine = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
        })
    analyst = SalesAnalyst.new(engine)

    assert_instance_of Array, analyst.items_per_merchant
    assert_equal 475, analyst.items_per_merchant.count
  end

  def test_it_can_give_average_items_per_merchant
    engine = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
        })
    analyst = SalesAnalyst.new(engine)

    assert_equal 2, analyst.average_items_per_merchant
  end

  def test_we_can_find_average_standard_deviation
    engine = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
        })
    analyst = SalesAnalyst.new(engine)

    assert_equal 3.26, analyst.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count
    engine = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
        })
    analyst = SalesAnalyst.new(engine)

    assert_instance_of Array, analyst.merchants_with_high_item_count
    assert_equal 114, analyst.merchants_with_high_item_count.count
  end

  def test_average_item_price_for_merchant
    engine = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
        })
    analyst = SalesAnalyst.new(engine)

    assert_instance_of BigDecimal, analyst.average_item_price_for_merchant(12334159)
    assert_equal 0.315e2, analyst.average_item_price_for_merchant(12334159)
  end

  def test_it_can_find_average_average_price_per_merchants
    engine = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
        })
    analyst = SalesAnalyst.new(engine)

    assert_instance_of BigDecimal, analyst.average_average_price_per_merchant
    assert_equal 0.35029e3, analyst.average_average_price_per_merchant
  end

  def test_golden_items
    engine = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
        })
    analyst = SalesAnalyst.new(engine)

    assert_instance_of Array, analyst.golden_items
    assert_equal 146, analyst.golden_items.count
  end

  def test_average_price
    engine = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
        })
    analyst = SalesAnalyst.new(engine)

    assert_instance_of BigDecimal, analyst.average_price
    assert_equal 0.2510e3, analyst.average_price
  end

  def test_average_price_standard_deviation
    engine = SalesEngine.from_csv({
        :items     => "./data/items.csv",
        :merchants => "./data/merchants.csv",
        })
    analyst = SalesAnalyst.new(engine)

    assert_instance_of BigDecimal, analyst.average_price_standard_deviation
    assert_equal 0.1e1, analyst.average_price_standard_deviation
  end
end
