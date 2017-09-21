require "./test/test_helper"
require "./lib/sales_engine"
require "./lib/merchant_repository"
require "./lib/merchant"

class MerchantRepositoryTest < Minitest::Test

  attr_reader :merchant_repository

  def setup
    merchant_csv = "./test/test_fixtures/merchants_medium.csv"
    @merchant_repository = MerchantRepository.new("fake_se", merchant_csv)
  end

  def test_it_exists
    assert_instance_of MerchantRepository, merchant_repository
  end

  def test_it_makes_array_of_merchants
    assert_instance_of Array, merchant_repository.all
  end

  def test_it_returns_nil_for_invalid_id
    assert_nil  merchant_repository.find_by_id(1234)
  end

  def test_it_returns_merchant_instance_for_id
    assert_instance_of Merchant, merchant_repository.find_by_id(12334105)
  end

  def test_it_returns_nil_for_invalid_name
    assert_nil  merchant_repository.find_by_name("Shopin")
  end

  def test_it_returns_merchant_instance_for_name
    assert_instance_of Merchant, merchant_repository.find_by_name("Shopin1901")
  end

  def test_it_returns_merchant_instance_for_partial_name
    assert_equal [], merchant_repository.find_all_by_name("Skittles12345")
  end

  def test_it_returns_merchant_instance_for_partial_name
    assert_instance_of Array, merchant_repository.find_all_by_name("I")
  end

  def test_it_returns_merchant_instance_for_partial_name
    assert_instance_of Merchant, merchant_repository.find_all_by_name("I")[0]
  end

  def test_it_finds_merchants_registered_in_month
    merchants_in_january = merchant_repository.merchants_registered_in_month("January")

    assert_instance_of Array, merchants_in_january
    assert_instance_of Merchant, merchants_in_january[0]
  end

  def test_inspect
    assert_instance_of String, merchant_repository.inspect
  end

end
