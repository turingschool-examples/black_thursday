require_relative 'test_helper'
require 'csv'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def test_it_opens_csv_into_array
    merchant = MerchantRepository.new
    actual   = merchant.all_merchant_data.class
    expected = Array

    assert_equal expected, actual
  end

  def test_it_returns_merchant_instances
    skip #No visible difference...
    merchant = MerchantRepository.new
    actual   = merchant.all[0]
    expected = "#<Merchant:0xXXXXXX @id=\"12334105\", @name=\"Shopin1901\">"

    assert_equal expected, actual
  end

  def test_it_can_return_ids
    merchant = MerchantRepository.new
    actual   = merchant.find_by_id("12334105")
    expected = merchant.all[0]

    assert_equal expected, actual
  end

  def test_it_can_return_names
    merchant = MerchantRepository.new
    actual   = merchant.find_by_name("Shopin1901")
    expected = merchant.all[0]

    assert_equal expected, actual
  end

  def test_it_can_find_all_by_name
    merchant = MerchantRepository.new
    actual   = merchant.find_all_by_name("shopin")
    expected = [merchant.all[0]]

    assert_equal expected, actual
  end

end
