# require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_that_sales_engine_is_instatiated
    se = SalesEngine.from_csv({some: "hash"})
    actual = se.class
    expected = SalesEngine
    assert_equal expected, actual
  end

  def test_from_csv_takes_hashes
    skip
    se = SalesEngine.new
    actual = se.from_csv()
    expected = "Something"
  end
end
