require_relative 'test_helper'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def setup
    @mr = MerchantRepository.new
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @mr
  end

  def test_create_adds_merchant
    @mr.create(name: 'Mr. Merchant')
    assert_equal 1, @mr.all.size
    assert_equal 1, @mr.all[0].id
    assert_equal 'Mr. Merchant', @mr.all[0].name
  end

  def test_create_adds_merchants
    @mr.create(name: 'Mr. Merchant')
    @mr.create(name: 'Mrs. Merchant')
    assert_equal 2, @mr.all.size
    assert_equal 2, @mr.find_by_name('Mrs. Merchant').id
    assert_equal 'Mrs. Merchant', @mr.find_by_id(2).name
  end

  def test_update_updates_name
    @mr.create(name: 'Mr. Merchant')
    @mr.update(1, name: 'Dr. Merchant')
  end
end
