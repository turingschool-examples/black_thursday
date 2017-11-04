require_relative 'test_helper'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'

class SalesAnalystTest < Minitest::Test

  def setup
    sales_engine = SalesEngine.from_csv({:items => './test/fixtures/items_fixture.csv',
                                        :merchants => './test/fixtures/merchants.csv',
                                        :invoices => './test/fixtures/invoices.csv'})
    @sales_analyst = SalesAnalyst.new(sales_engine)
  end

  def test_that_we_find_average_items_per_merchant
    assert_equal 0.83, @sales_analyst.average_items_per_merchant
  end

  def test_it_can_find_standard_deviation
    assert_equal 1.06, @sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_it_can_find_merchants_with_high_item_count
    assert_equal [1,7,11], @sales_analyst.merchants_with_high_item_count
  end

end
