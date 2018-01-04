require 'simplecov'
SimpleCov.start do
  add_filter "/test/"
end
require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/sales_engine"
require "pry"


class SalesEngineTest < Minitest::Test

  CSV_FILES = {
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
  }


  def test_it_exists
    se = SalesEngine.new(CSV_FILES)

    assert_instance_of SalesEngine, se
  end

  def test_it_initializes_new_items
    skip
    se = SalesEngine.new(CSV_FILES)

    assert_instance_of Items, se.items
  end

  def test_it_initializes_new_merchants
    skip
    se = SalesEngine.new(CSV_FILES)

    assert_instance_of Merchants, se.merchants
  end

end
