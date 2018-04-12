# frozen_string_literal: true

require_relative 'test_helper'
require './lib/sales_engine'
require 'pry'

# This is a sales analyst class

class SalesAnalystTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv
    @sa = SalesAnalyst.new(@se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sa
    assert_equal @se, @sa.engine
  end

  def test_average_items_per_merchant
    assert_equal 2.88, @sa.average_items_per_merchant
  end

  def test_standard_deviation
    actual = @sa.average_items_per_merchant_standard_deviation
    assert_equal 3.26, actual
  end
end
