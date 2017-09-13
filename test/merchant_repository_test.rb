require "./test/test_helper"
require "./lib/merchant_repository"
require "./lib/merchant"
require "csv"


class MerchantRepositoryTest < Minitest::Test

  attr_reader :mr

  def setup
    merchant_csv = "./test/test_data/merchants_short.csv"
    @mr = MerchantRepository.new("fake_se", merchant_csv)

  end

  def test_it_exists
    assert_instance_of MerchantRepository, mr
  end

  def test_it_makes_array_of_merchants
    assert_instance_of Array, mr.all
  end

  def test_it_returns_nil_for_invalid_id
    assert_nil  mr.find_by_id(1234)
  end

  def test_it_returns_merchant_instance_for_id
    assert_instance_of Merchant, mr.find_by_id(12334105)
  end

  def test_it_returns_nil_for_invalid_name
    assert_nil  mr.find_by_name("Shopin")
  end

  def test_it_returns_merchant_instance_for_name
    assert_instance_of Merchant, mr.find_by_name("Shopin1901")
  end

  def test_it_returns_merchant_instance_for_partial_name
    assert_instance_of Array, mr.find_all_by_name("I")
  end

end
