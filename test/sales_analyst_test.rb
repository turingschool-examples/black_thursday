# require 'simplecov'
# SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_analyst'
# require './lib/sales_engine'
# require './lib/merchant_repo'
# require './lib/merchant'
# require './lib/item_repo'
# require './lib/item'

class SalesAnalystTest < Minitest::Test

  def test_sales_analyst_exists

    se = SalesEngine.from_csv({
                              :items     => "./fixtures/sales_analyst_item_sample.csv",
                              :merchants => "./data/merchants.csv",
                              })

    sales_analyst = se.analyst

    assert_instance_of SalesAnalyst, sales_analyst
  end

  # def test_average_items_per_merchant
  #   se = SalesEngine.from_csv({
  #                             :items     => "./fixtures/sales_analyst_item_sample.csv",
  #                             :merchants => "./data/merchants.csv",
  #                             })
  #
  #   sales_analyst = se.analyst
  #
  #   assert_equal sales_analyst.average_items_per_merchant, 2.88
  # end

  # def test_average_items_per_merchant_standard_deviation
  # end

end
