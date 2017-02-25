require_relative 'test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
    attr_reader :se

  def setup
    @se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })
  end

  def test_it_is_a_sales_engine
    assert_equal SalesEngine, se.class
  end

  def test_from_csv_returns_hash_and_is_not_nil
    assert_equal Hash, se.paths.class
    result = {:items=>"./data/items.csv", :merchants=>"./data/merchants.csv"}
    assert_equal result, se.paths
    refute se.paths.empty?
  end

  def test_can_we_get_items_file_path_from_hash
    assert_equal "./data/items.csv", se.paths[:items]
  end

  def test_can_we_get_merchants_file_path_from_hash
    assert_equal "./data/merchants.csv", se.paths[:merchants]
  end

  def test_can_we_retrieve_keys
    assert_equal [:items, :merchants], se.paths.keys
  end

  def test_can_retrieve_values
    assert_equal ["./data/items.csv", "./data/merchants.csv"], se.paths.values
  end

  def test_from_csv_can_take_another_hash
    skip
    test_hash = {:transactions => "./data/transactions.csv"}
    se.from_csv(test_hash)
    assert_equal 3, se.paths.keys.count
    assert_equal :transactions, se.paths.keys.last
    assert_equal [:items, :merchants, :transactions], se.paths.keys
  end
end
