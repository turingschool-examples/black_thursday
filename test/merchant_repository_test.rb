require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository'
require_relative '../lib/sales_engine'

class MerchantRepositoryTest < Minitest::Test

  attr_reader :merch_repo

  def setup
    small_csv_paths = {
                        :items     => "./data/small_item_set.csv",
                        :merchants => "./data/merchant_sample.csv",
                      }
    engine = SalesEngine.from_csv(small_csv_paths)
    csv = CSV.open('./data/merchant_sample.csv', headers: true, header_converters: :symbol)
    @merch_repo = MerchantRepository.new(csv, engine)
  end

  def test_merchant_repository_exists
    assert_instance_of MerchantRepository, merch_repo
  end

  def test_it_can_add_merchants
    csv = CSV.open('./data/merchant_sample.csv', headers: true, header_converters: :symbol)

    merch_repo.merchants.clear

    merch_repo.add(csv)
    random_merch_key = merch_repo.merchants.keys.sample

    assert_instance_of Merchant, merch_repo.merchants[random_merch_key]
  end

  def test_it_can_return_all_merchants
    actual = merch_repo.all
    assert_equal 5, actual.length
    assert_instance_of Merchant, actual.sample
  end

  def test_it_can_find_merchants_by_id
    assert_instance_of Merchant, merch_repo.find_by_id("12334105")
  end

  def test_it_returns_nil_for_invalid_id
    assert_nil merch_repo.find_by_id("42")
  end

  def test_it_can_find_merchants_by_name
    assert_instance_of Merchant, merch_repo.find_by_name("Candisart")
  end

  def test_it_returns_nil_for_invalid_name
    assert_nil merch_repo.find_by_name("Stuff")
  end

  def test_it_can_find_all_merchants_containing_given_name_fragment
    merch_1 = merch_repo.find_by_id("12334113")
    merch_2 = merch_repo.find_by_id("12334123")

    assert_equal [], merch_repo.find_all_by_name("jjj")
    assert_equal [merch_1, merch_2], merch_repo.find_all_by_name("ke")
  end

  def test_it_knows_about_parent_sales_engine
    assert_instance_of SalesEngine, merch_repo.engine
  end

  def test_it_can_get_merchant_items_from_parent_sales_engine
    actual = merch_repo.all_merchant_items(12334213)

    assert_instance_of Array, actual
    assert_instance_of Item, actual.sample
    assert_equal 2, actual.count
    assert_equal 12334213, actual.sample.merchant_id
  end
end
