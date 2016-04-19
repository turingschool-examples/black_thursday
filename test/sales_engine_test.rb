require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine.rb'
require './lib/csv_parser.rb'


class SalesEngineTest < MiniTest::Test
   attr_reader :se

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
  end

  def test_it_creates_instance
    assert se
  end

  def test_it_creates_item_repository_instance
    assert se.items
  end

  def test_it_creates_merchant_repository_instance
    assert se.merchants
  end


end
