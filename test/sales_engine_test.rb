require_relative './test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest <Minitest::Test
  def test_it_exists
  se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
  })


  end

  def test_it_has_from_csv
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })
    assert_equal ({items: './data/items.csv', merchants: './data/merchants.csv'}), se.data
  end

  def test_it_has_items
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })
    assert_instance_of Array, se.items.items
  end

  def test_it_has_merchants
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })
    assert_instance_of Array, se.merchants.merchants
  end
end
