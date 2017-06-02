require_relative 'test_helper'
require_relative '../lib/merchant_repository'
require 'csv'

class MerchantRepositoryTest < Minitest::Test
  def setup
    @merchant = MerchantRepository.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv"
      })
  end
  def test_merchant_repo_instantiates
    actual   = @merchant.class
    expected = MerchantRepository

    assert_equal expected, actual
  end

  def test_it_opens_csv_into_array
    actual   = @merchant.all_merchant_data.class
    expected = Array

    assert_equal expected, actual
  end

  def test_it_returns_merchant_instances
    actual   = @merchant.all[0].class
    expected = Merchant

    assert_equal expected, actual
  end

  def test_it_can_return_ids
    actual   = @merchant.find_by_id(12334105)
    expected = @merchant.all[0]

    assert_equal expected, actual
  end

  def test_it_can_return_names
    actual   = @merchant.find_by_name("Shopin1901")
    expected = @merchant.all[0]

    assert_equal expected, actual
  end

  def test_it_can_find_all_by_name
    actual   = @merchant.find_all_by_name("shopin")
    expected = [@merchant.all[0]]

    assert_equal expected, actual
  end

end
