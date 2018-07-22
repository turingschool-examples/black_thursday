require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'
require_relative './test_helper'

class MerchantRepositoryTest < Minitest::Test
  def setup
    @merchants =
      [{id: '12334105',
      name: 'Shopin1901',
      created_at: '2010-12-10',
      updated_at: '2011-12-04'},
      {id: '12334112',
      name: 'Candisart',
      created_at: '2009-05-30',
      updated_at: '2010-08-29'},
      {id: '12334113',
      name: 'MiniatureBikez',
      created_at: '2010-03-30',
      updated_at: '2013-01-21'}]

    @merchant_repository = MerchantRepository.new(@merchants)
  end

  def test_it_exist
    assert_instance_of MerchantRepository, @merchant_repository
  end

  def test_it_can_build_merchant
    assert_equal Array, @merchant_repository.build_merchant(@merchants).class
  end

  def test_can_get_an_array_of_merchants
    assert_equal 3, @merchant_repository.all.count
  end

  def test_it_can_find_a_merchant_by_a_valid_id
    merchant = @merchant_repository.find_by_id('12334105')
    assert_instance_of Merchant, merchant
    assert_equal '12334105', merchant.id
  end

  def test_it_returns_nil_if_merchant_id_is_invalid
    merchant = @merchant_repository.find_by_id('invalid')
    assert_nil merchant
  end

  def test_it_can_find_a_merchant_by_name
    merchant = @merchant_repository.find_by_name('Candisart')
    assert_instance_of Merchant, merchant
    assert_equal 'Candisart', merchant.name
  end

  def test_it_returns_nil_if_merchant_name_is_invalid
    merchant = @merchant_repository.find_by_name('invalid')
    assert_nil merchant
  end

  def test_merchant_find_by_name_is_case_insensitive
    merchant = @merchant_repository.find_by_name('candisart')
    assert_equal 'Candisart', merchant.name
  end

  def test_find_all_by_name_or_name_fragment
    merchants_1 = @merchant_repository.find_all_by_name('Bike')
    merchants_2 = @merchant_repository.find_all_by_name('zzzz')
    merchants_3 = @merchant_repository.find_all_by_name('in')
    assert_equal 'MiniatureBikez', merchants_1.first.name
    assert_equal ([]), merchants_2
    assert_equal 'Shopin1901', merchants_3.first.name
    assert_equal 'MiniatureBikez', merchants_3[1].name
  end
end
