require './lib/salesengine'
require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
class SalesEngineTest < Minitest::Test
  def test_it_exists
    se = SalesEngine.new
    assert_instance_of SalesEngine, se
  end

  def test_from_csv
    se = SalesEngine.from_csv({items: "./data/items.csv", merchants: "./data/merchants.csv"})
    assert_instance_of Hash, se.from_csv
  end

  def test_create_merchant_repo
    se = SalesEngine.from_csv({items: "./data/items.csv", merchants: "./data/merchants.csv"})
    assert_equal @merchants, se.create_merchant_repo
  end
end
