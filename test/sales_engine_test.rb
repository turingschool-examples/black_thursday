require 'minitest/autorun'
require 'minitest/nyan_cat'
require './lib/sales_engine'


class SalesEngineTest < Minitest::Test
  attr_reader :sales_engine

  def setup
    @sales_engine = SalesEngine.new
  end

  def test_it_exists
    assert sales_engine
  end

  def test_it_initializes_with_merchants
    assert sales_engine.merchants
  end

  def test_it_initializes_with_items
    assert sales_engine.items
  end

end
