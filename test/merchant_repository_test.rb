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

  def test_it_can_find_all_by_name
    assert_instance_of MerchantRepository, @mr
  end

  def test_merchant_repo_has_merchants
    assert_equal 13 , @mr.all.count
    assert_instance_of Array, @mr.all
  end
end
