require_relative './test_helper'
require './lib/merchant_repository'
require './lib/merchant'

class MerchantRepositoryTest < Minitest::Test
  def setup
    @merchants = [{ id: 12334105,
                    name: 'Shopin1901',
                    created_at: '2010-12-10',
                    updated_at: '2011-12-04' },
                  { id: 12334112,
                    name: 'Candisart',
                    created_at: '2009-05-30',
                    updated_at: '2010-08-29' },
                  { id: 12334113,
                    name: 'MiniatureBikez',
                    created_at: '2010-03-30',
                    updated_at: '2013-01-21' }]

    @merchant_repository = MerchantRepository.new(@merchants)
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @merchant_repository
  end

  def test_it_can_build_merchant
    assert_equal Array, @merchant_repository.build_merchant(@merchants).class
  end

  def test_can_get_an_array_of_merchants
    assert_equal 3, @merchant_repository.all.count
  end

  def test_it_can_find_a_merchant_by_a_valid_id
    merchant = @merchant_repository.find_by_id(12334105)
    assert_instance_of Merchant, merchant
    assert_equal 12334105, merchant.id
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
    merchants_one = @merchant_repository.find_all_by_name('Bike')
    merchants_two = @merchant_repository.find_all_by_name('zzzz')
    merchants_three = @merchant_repository.find_all_by_name('in')
    assert_equal 'MiniatureBikez', merchants_one.first.name
    assert_equal ([]), merchants_two
    assert_equal 'Shopin1901', merchants_three.first.name
    assert_equal 'MiniatureBikez', merchants_three[-1].name
  end

  def test_it_can_find_highest_id
    merchant = @merchant_repository.find_highest_id
    assert_equal 12334113, merchant.id
  end

  def test_it_can_create_new_id
    merchant = @merchant_repository.create_id
    assert_equal 12334114, merchant
  end

  def test_it_can_create_new_merchant
    attributes = { name: 'Turing School',
                   created_at: '2010-12-10',
                   updated_at: '2011-12-04' }
    merchant = @merchant_repository.create(attributes)
    assert_equal 'Turing School', merchant.name
    assert_equal 12334114, merchant.id
  end

  def test_it_can_update_merchant_name
    attributes = {
      name: 'Shopin2001'
    }
    id = 12334105
    @merchant_repository.update(id, attributes)
    expected = @merchant_repository.find_by_id(id)
    assert_equal 'Shopin2001', expected.name
    expected = @merchant_repository.find_by_name('Shopin1901')
    assert_nil expected
  end

  def test_it_can_delete_merchant
    id = 12334105

    @merchant_repository.delete(id)
    expected_one = @merchant_repository.find_by_name('Shopin1901')
    expected_two = @merchant_repository.find_by_id(id)

    assert_nil expected_one
    assert_nil expected_two
  end
end
