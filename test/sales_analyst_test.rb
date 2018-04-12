# frozen_string_literal: true

require_relative 'test_helper'
require './lib/sales_engine'
require 'pry'

# This is a sales analyst class

class SalesAnalystTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({items: './test/fixtures/items_truncated.csv',
                               merchants: './test/fixtures/merchants_truncated.csv',})
    @sa = SalesAnalyst.new(@se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @sa
    assert_equal @se, @sa.engine
  end

  def test_average_items_per_merchant
    assert_equal 0.83, @sa.average_items_per_merchant
  end
end
