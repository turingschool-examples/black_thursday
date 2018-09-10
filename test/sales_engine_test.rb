require_relative './test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest <Minitest::Test
  def test_it_exists
  se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
  })

  assert_instance_of SalesEngine, se
  end

  def test_it_has_from_csv
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })
    assert_equal ({items: './data/items.csv', merchants: './data/merchants.csv'}), se.data
  end
end
