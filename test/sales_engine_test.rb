require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_from_csv_intializes_se_with_merchants_and_items
    se = SalesEngine.from_csv({
              :merchants => '../test/fixtures/merchants_fixtures.csv',
              :items     => '../test/fixtures/items_fixtures.csv'
              })
    assert_equal MerchantRepository, se.merchants.class
    assert_equal ItemRepository, se.items.class
    assert_equal SalesAnalyst, se.sales_analyst.class
  end

end
