# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test
  def test_it_exists
    merchant = Merchant.new({ id: '5', name: 'Turing School' }, MOCK_MERCHANT_REPOSITORY)

    assert_instance_of Merchant, merchant
  end

  def test_it_has_attributes
    merchant = Merchant.new({ id: '5', name: 'Turing School' }, MOCK_MERCHANT_REPOSITORY)

    assert_equal 5, merchant.id
    assert_equal 'Turing School', merchant.name
  end

  def test_it_can_have_different_attributes
    merchant = Merchant.new({ id: '3', name: 'Yale' }, MOCK_MERCHANT_REPOSITORY)

    assert_equal 3, merchant.id
    assert_equal 'Yale', merchant.name
  end

  def test_can_find_all_items
    merchant = MOCK_SALES_ENGINE.merchants.find_by_id 7
    assert_equal 2, merchant.items.length
  end
end
