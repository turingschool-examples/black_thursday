require_relative 'test_helper'
require_relative '../lib/sales_engine'
require 'minitest/autorun'
require 'minitest/pride'


class SalesEngineTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.new

    assert SalesEngine, se
  end

  def test_it_pulls_in_items
    se = SalesEngine.new("./data/items.csv")
    result = se.include?("glitter")

    assert result, se.from_csv({})
  end
end
