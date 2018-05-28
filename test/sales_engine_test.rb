require_relative 'test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def setup
    @file_paths = {:items     => './data/items.csv',
                  :merchants => './data/merchants.csv'}
    @se = SalesEngine.new(@file_paths)
  end

  def test_it_exists
    assert_instance_of SalesEngine, @se
  end

  def test_parse_csv_returns_hash
    assert_instance_of Hash, @se.parse_csv(@file_paths[:items])
  end

  def test_parse_csv_returns_hash_keys_are_ids
    assert_equal '263395237', @se.parse_csv(@file_paths[:items]).keys[0]
    assert_equal '12334105', @se.parse_csv(@file_paths[:merchants]).keys[0]
  end

  def test_parse_csv_returns_entire_file_contents
    assert_equal 1367, @se.parse_csv(@file_paths[:items]).length
    assert_equal 475, @se.parse_csv(@file_paths[:merchants]).length
  end

  def test_id_key_matches_values_id
    merchants = @se.parse_csv(@file_paths[:merchants])
    assert merchants.all? do |merch|
      merch.keys[0] == merch[:id]
    end
  end

  def test_from_csv_returns_hash_for_each_file
    assert_equal @file_paths.length, @se.from_csv(@file_paths).length
  end
end
