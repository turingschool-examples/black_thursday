require_relative 'test_helper'
require './lib/merchant_repository'

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

  def test_this
    merchants = @merchant_repository.all
    assert merchants.all? do |merch|
      merch.class == Merchant
    end
  end
end
