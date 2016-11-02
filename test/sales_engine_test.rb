require 'minitest/autorun'
require 'minitest/emoji'
require 'csv'
require 'bigdecimal'
require './lib/sales_engine'


class SalesEngineTest < Minitest::Test

  def test_it_exists
    assert SalesEngine, SalesEngine.class
  end

  def test_it_can_instantiate_merchant_repo
    new = SalesEngine.new("data/small_merchant_file.csv")
    refute new.merchants.nil?
  end

  def test_it_can_instantiate_item_repo
    new = SalesEngine.new("data/small_item_file.csv")
    refute new.items.nil?
  end
end