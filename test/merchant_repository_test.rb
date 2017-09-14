require_relative 'test_helper'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  attr_reader :mr

  def setup
    @mr = MerchantRepository.new('./test/fixtures/merchants_truncated_4.csv')
  end

  def test_it_exists
    assert_instance_of MerchantRepository, mr
  end

  def test_it_has_a_parent_defaulted_to_nil
    assert_nil mr.parent
  end

  def test_load_csv
    assert_equal 4, mr.merchants.length
    actual = mr.load_csv('./test/fixtures/merchants_truncated_4.csv')

    assert_equal 8, mr.merchants.length
  end

  def test_merchants_returns_array
    actual = mr.merchants

    assert_instance_of Merchant, actual[0]
    assert_instance_of Merchant, actual[1]
    assert_equal 4, actual.length
  end

  def test_all_returns_array_of_merchants
    actual = mr.all

    assert_instance_of Merchant, actual[0]
    assert_instance_of Merchant, actual[1]
    assert_equal 4, actual.length
  end

  def test_find_by_id_returns_nil_with_invalid_id
    actual = mr.find_by_id(666)

    assert_nil actual
  end

  def test_find_by_id_returns_merchant_with_valid_id
    actual = mr.find_by_id(12334105)
    expected = mr.merchants[0]

    assert_equal expected, actual
  end

  def test_find_by_name_returns_nil_with_invalid_name
    actual = mr.find_by_name("Imakejunk")

    assert_nil actual
  end

  def test_find_by_name_returns_merchant_with_valid_name
    actual = mr.find_by_name("Shopin1901")
    expected = mr.merchants[0]

    assert_equal expected, actual
  end

  def test_find_by_name_returns_merchant_with_valid_name_case_insensitive
    actual = mr.find_by_name("shopin1901")
    expected = mr.merchants[0]

    assert_equal expected, actual
  end

  def test_find_all_by_name_returns_empty_array_with_invalid_name_search
    actual = mr.find_all_by_name("store")

    assert_equal [], actual
  end

  def test_find_all_by_name_returns_merchant_with_valid_name_search
    actual = mr.find_all_by_name("i")
    expected = [mr.merchants[0], mr.merchants[1]]

    assert_equal expected, actual
  end

end
