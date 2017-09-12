require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository'
require 'pry'

class MerchantRepositoryTest < Minitest::Test

  attr_reader :mr

  def setup
    @mr = MerchantRepository.new('./data/merchants_test.csv')
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @mr
  end

  def test_merchant_list_returns_array
    actual = @mr.merchant_list

    assert_instance_of Merchant, actual[0]
    assert_instance_of Merchant, actual[1]
    assert_equal 4, actual.length
  end

  def test_all_returns_array_of_merchants
    actual = @mr.all

    assert_instance_of Merchant, actual[0]
    assert_instance_of Merchant, actual[1]
    assert_equal 4, actual.length
  end

  def test_find_by_id_returns_nil_with_invalid_id
    actual = @mr.find_by_id(666)

    assert_nil actual
  end

  def test_find_by_id_returns_merchant_with_valid_id
    actual = @mr.find_by_id(12334105)
    expected = @mr.merchant_list[0]

    assert_equal expected, actual
  end

  def test_find_by_name_returns_nil_with_invalid_name
    actual = @mr.find_by_name("Imakejunk")

    assert_nil actual
  end

  def test_find_by_name_returns_merchant_with_valid_name
    actual = @mr.find_by_name("Shopin1901")
    expected = @mr.merchant_list[0]

    assert_equal expected, actual
  end

  def test_find_by_name_returns_merchant_with_valid_name_case_insensitive
    actual = @mr.find_by_name("shopin1901")
    expected = @mr.merchant_list[0]

    assert_equal expected, actual
  end

  def test_find_all_by_name_returns_empty_array_with_invalid_name_search
    skip
    actual = @mr.find_all_by_name("store")

    assert_equal [], actual
  end

  def test_find_all_by_name_returns_merchant_with_valid_name_search
    skip
    actual = @mr.find_all_by_name("i")

    assert_equal
  end

end
