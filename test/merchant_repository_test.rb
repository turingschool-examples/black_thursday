require_relative 'test_helper'
require './lib/merchant_repository'
require './lib/merchant'

class MerchantRepositoryTest < Minitest::Test
  def setup
    @se = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
    })
    @merchant_repository = @se.merchants
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @merchant_repository
  end

  def test_it_can_convert_CSV_table_to_hash
    assert_instance_of Hash, @merchant_repository.parse_csv
  end

  def test_parse_csv_returns_hash_keys_that_are_ids
    assert_equal '12334105', @merchant_repository.parse_csv.keys[0]
  end

  def test_parse_csv_returns_entire_file_contents
    assert_equal 475, @merchant_repository.parse_csv.length
  end

  def test_id_key_matches_values_id
    merchants = @merchant_repository.parse_csv
    assert merchants.all? do |merch|
      merch.keys[0] == merch[:id]
    end
  end

  def test_merchant_repo_holds_all_instances_of_merchants
    assert_equal 475, @merchant_repository.all.length
  end

  def test_all_returns_array_of_all_merchant_objects
    merchants = @merchant_repository.all
    assert merchants.all? do |merch|
      merch.class == Merchant
    end
  end

  def test_find_by_id_returns_merchants_with_given_id
    refute @merchant_repository.find_by_id('notarealid')
    assert_instance_of Merchant, @merchant_repository.find_by_id('12334105')
    assert_equal '12334105', @merchant_repository.find_by_id('12334105').id
    assert_equal 'Shopin1901', @merchant_repository.find_by_id('12334105').name
  end

  def test_find_by_name_returns_merchant_object_with_given_name
    refute @merchant_repository.find_by_name('notarealname')
    assert_instance_of Merchant, @merchant_repository.find_by_name('Candisart')
    assert_equal '12334112', @merchant_repository.find_by_name('Candisart').id
    assert_equal 'Candisart', @merchant_repository.find_by_name('Candisart').name
  end

  def test_find_all_by_name_fragment
    assert_instance_of Array, @merchant_repository.find_all_by_name('art')
    assert_equal 7, @merchant_repository.find_all_by_name('art').length
    assert_equal [], @merchant_repository.find_all_by_name('asdgihweogdv')
    # assert_equal [], @merchant_repository.find_all_by_name('art')
  end






end
