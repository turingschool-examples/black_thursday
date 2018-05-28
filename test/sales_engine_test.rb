require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine.rb'
require 'pry'

class SalesEngineTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.from_csv("content")
    assert_instance_of SalesEngine, se
  end

  def test_it_has_from_csv
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
    assert_equal ({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      }), se.content
  end

  def test_merchants_creates_array_of_merchants
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
    assert_equal 475, se.merchants.repository.count
  end

end
