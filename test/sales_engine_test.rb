require_relative 'minitest_helper'
require './lib/sales_engine'
require 'CSV'

class SalesEngineTest < Minitest::Test

  def test_from_csv_intializes_se_with_merchants_items
    se = SalesEngine.from_csv({
    :merchants     => './test/fixtures/merchants_fixtures.csv',
    :items         => './test/fixtures/items_fixtures.csv'
                              })
    assert_equal MerchantRepository, se.merchants.class
    assert_equal ItemRepository, se.items.class
  end

end
