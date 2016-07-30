gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require 'bigdecimal'


class SalesAnalystTest < MiniTest::Test
  def setup
    @sa = SalesAnalyst.new(SalesEngine.new({
                                             :items     => "./data/items.csv",
                                             :merchants => "./data/merchants.csv",
                                            }))
  end

  def test_it_has_copy_of_sales_engine
    assert_instance_of SalesEngine, @sa.sales_engine
  end

  def test_it_returns_items_by_merchant

  end
