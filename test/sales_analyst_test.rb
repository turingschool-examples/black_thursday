# frozen_string_literal: true

require 'simplecov'
SimpleCov.start
require 'bigdecimal'
require 'minitest'
require 'minitest/emoji'
require 'minitest/autorun'
require './lib/sales_engine.rb'
require './lib/sales_analyst.rb'

class SalesAnalystTest < MiniTest::Test
  def setup
    @se = SalesEngine.from_csv(
      items:      './data/items.csv',
      merchants:  './data/merchants.csv'
    )
    @s = SalesAnalyst.new(@se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @s
  end

  def test_it_gives_average_items_per_merchant
    expected = 2.88
    actual = BigDecimal(@s.average_items_per_merchant, 3)

    assert_equal expected, actual
  end

  def test_it_can_calculate_standard_deviation
    expected = 3.26
    actual = @s.average_items_per_merchant_standard_deviation

    assert_equal expected, actual
  end
end
