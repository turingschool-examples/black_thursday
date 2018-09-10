require './test/minitest_helper'
require './lib/merchant_repository'
require './lib/merchant'
require 'CSV'

class MerchantTest < Minitest::Test
  def setup
    @mr = MerchantRepository.new('./test/fixtures/merchants_fixtures.csv')
  end

  def test_it_exists
    assert_instance_of MerchantRepository, @mr
  end

  def test_merchant_repo_has_merchants
    assert_equal 13 , @mr.all.count
    assert_instance_of Array, @mr.all
  end

  def test_it_can_find_merchant_by_id
    result = @mr.find_by_id(12334105)
    assert_instance_of Merchant, result
    assert_equal 12334105, result.id
    assert_equal "Shopin1901", result.name
  end

  def test_it_can_find_merchants_by_name
    result = @mr.find_by_name("Candisart")
    assert_equal "Candisart", result.name
  end

  def test_it_can_find_all_by_name
    result = @mr.find_all_by_name("Urcase17")
    assert_equal "Urcase17", result.first.name
  end

  def test_you_can_create_new_merchant_with_incrimented_id
    new_merchant = @mr.create({:name => "Aizar Aaron"})
    assert_equal "Aizar Aaron", new_merchant.name
    assert_equal 12334156, new_merchant.id
  end

  def test_new_merchant_instance_can_update_name
    new_merchant = @mr.create({:name => "Aizar Aaron"})
    @mr.find_by_id(12334156)
    result = @mr.update(12334156, {:name => "DudeMan"})
    # require 'pry'; binding.pry
    assert_equal "DudeMan", result.name
  end
end
