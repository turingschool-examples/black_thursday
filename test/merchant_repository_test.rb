require './lib/merchant_repository'
require './lib/merchant'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'


class MerchantTest < Minitest::Test

  def test_it_exists
    mr = MerchantRepository.new("./data/merchants.csv")

    assert_instance_of MerchantRepository, mr
  end

  def test_all_returns_all_merchants_in_the_correct_format
    mr = MerchantRepository.new("./data/merchants.csv")

    assert_instance_of Merchant, mr.merchants[0]
    assert_equal 'Shopin1901', mr.merchants[0].name
    assert_equal 12334105, mr.merchants[0].id
    assert_equal 475, mr.merchants.count
  end

  def test_find_by_id_returns_specified_merchant_instance
    mr = MerchantRepository.new("./data/merchants.csv")
    merchant = mr.find_by_id(12334105)
    nil_merchant = mr.find_by_id(1231412543534543)

    assert_equal 'Shopin1901', merchant.name
    assert_nil nil_merchant
  end

  def test_find_by_name_returns_specified_merchant_instance
    mr = MerchantRepository.new("./data/merchants.csv")
    merchant = mr.find_by_name('Shopin1901')
    nil_merchant = mr.find_by_name('Sals hammocks')
    merchant_upcase = mr.find_by_name('SHOPIN1901')

    assert_equal 12334105, merchant.id
    assert_equal 12334105, merchant_upcase.id
    assert_nil nil_merchant
  end

  def test_find_all_by_name_returns_an_array_with_one_or_more_matches
    mr = MerchantRepository.new("./data/merchants.csv")
    merchant = mr.find_all_by_name('little')
    nil_merchant = mr.find_all_by_name('Sals hammocks')
    merchant_upcase = mr.find_all_by_name('LITTLE')

    assert_equal 4, merchant.count
    assert_equal 4, merchant_upcase.count
    assert_equal 0, nil_merchant.count
    assert_equal 'littledorisdesigns', merchant[0].name
    assert_equal 'littledorisdesigns', merchant_upcase[0].name
  end
end
