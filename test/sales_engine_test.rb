require 'simplecov'
SimpleCov.start do
  add_filter "/test/"
end
require "minitest/autorun"
require "minitest/pride"
require "./lib/sales_engine"
require "pry"


class SalesEngineTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.new

    assert_instance_of SalesEngine, se
  end

  def test_it_initializes_new_items
    skip
    se = SalesEngine.new

    assert_instance_of Items, se.items
  end

  def test_it_initializes_new_merchants
    skip
    se = SalesEngine.new

    assert_instance_of Merchants, se.merchants
  end

end
