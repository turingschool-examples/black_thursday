require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require 'merchant_test_helper'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test
  def test_it_exists
    merch = Merchant.new

    assert_instance_of Merchant, merch
  end

  def test_all_merchants
    merch = Merchant.new

    assert_includes "12337411, CJsDecor", merch
  end

  def test_it_can_find_by_id
  end

  def test_it_can_find_by_name
  end

  def test_it_can_find_all_by_name
  end

end
