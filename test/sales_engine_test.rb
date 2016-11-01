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

  def test_this_thing
    se = SalesEngine.from_csv({
    :items     => "./data/items_fixtures.csv",
    :merchants => "./data/merchants_fixtures.csv",
    })
  end

end
