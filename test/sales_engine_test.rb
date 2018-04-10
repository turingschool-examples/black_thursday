require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_it_exists
    se = SalesEngine.from_csv({
  :items     => "./fixtures/item.csv",
  :merchants => "./data/merchants.csv",
  })
  assert_instance_of SalesEngine, se
  end

  def test_data_can_be_parsed
    se = SalesEngine.from_csv({
  :items     => "./fixtures/item.csv",
  :merchants => "./data/merchants.csv",
  })
  result =({
    :items     => "./fixtures/item.csv",
    :merchants => "./data/merchants.csv",
    })
  assert_equal result, se.parse_data
  end
end
