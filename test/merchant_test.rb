# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant'
require_relative '../lib/invoice'
require_relative 'mocks/test_engine'

class MerchantTest < Minitest::Test
  def test_it_exists
    merchant = Merchant.new({ id: '5', name: 'Turing School' },
                            MOCK_MERCHANT_REPOSITORY)

    assert_instance_of Merchant, merchant
  end

  def test_it_has_attributes
    merchant = Merchant.new({ id: '5', name: 'Turing School' },
                            MOCK_MERCHANT_REPOSITORY)

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
    merchant2 = MOCK_SALES_ENGINE.merchants.find_by_id 9
    assert_equal 2, merchant.items.length
    assert_equal 0, merchant2.items.length
  end

  def test_can_find_invoices
    merchant = MOCK_SALES_ENGINE.merchants.find_by_id 7
    invoices = merchant.invoices

    assert_instance_of Array, invoices
    invoices.each do |invoice|
      assert_instance_of Invoice, invoice
      assert_equal 7, invoice.merchant_id
    end
  end
end
