require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  attr_reader :merch_repo

  def setup
    csv = CSV.open('./data/merchant_sample.csv', headers: true, header_converters: :symbol)
    @merch_repo = MerchantRepository.new(csv)
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
end
