require_relative './test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest <Minitest::Test
  def test_it_exists
    se = SalesEngine.from_csv({
    :items     => "./short_tests/short_items.csv",
    :merchants => "./short_tests/short_merchants.csv",
    })

    assert_instance_of SalesEngine, se
  end

  def test_it_has_from_csv
    se = SalesEngine.from_csv({
    :items     => "./short_tests/short_items.csv",
    :merchants => "./short_tests/short_merchants.csv",
    })
    assert_equal ({items: './short_tests/short_items.csv', merchants: './short_tests/short_merchants.csv'}), se.data
  end

  def test_it_has_items
    se = SalesEngine.from_csv({
    :items     => "./short_tests/short_items.csv",
    :merchants => "./short_tests/short_merchants.csv",
    })
    assert_instance_of Array, se.items.repo
  end

  def test_it_has_merchants
    se = SalesEngine.from_csv({
    :items     => "./short_tests/short_items.csv",
    :merchants => "./short_tests/short_merchants.csv",
    })
    assert_instance_of Array, se.merchants.repo
  end
end
