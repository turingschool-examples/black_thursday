require_relative 'test_helper'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/item'
require_relative '../lib/sales_engine'

# test for merchant class
class MerchantTest < Minitest::Test
  def test_it_exists
    merchant = Merchant.new({ id: '5', name: 'Turing School' }, 'parent')

    assert_instance_of Merchant, merchant
  end

  def test_it_has_attributes
    merchant = Merchant.new({ id: '5', name: 'Turing School' }, 'parent')

    assert_equal 5, merchant.id
    assert_equal 'Turing School', merchant.name
    assert_equal 'parent', merchant.parent
  end

  def test_it_has_different_attributes
    merchant = Merchant.new({ id: '3', name: 'UNT' }, 'parent')

    assert_equal 3, merchant.id
    assert_equal 'UNT', merchant.name
  end

  def test_items_method
    skip # stub
    merchant = Merchant.new({ id: '2', name: '' }, parent)

    assert_instance_of Array, merchant.items
    assert_instance_of Item, merchant.items[0]
    assert_equal 3, merchant.items.length
  end

  def test_invoices_method
    parent = mock
    parent.stubs(:pass_id_to_se_for_invoice).returns('invoice')
    merchant = Merchant.new({ id: '2', name: '' }, parent)
    assert_equal merchant.invoices, parent.pass_id_to_se_for_invoice
  end

  def test_customers_method
    parent = mock
    parent.stubs(:pass_customer_id_to_se).returns([])
    invoice = mock
    invoice.stubs(:customer_id).returns(1)
    parent.stubs(:pass_id_to_se_for_invoice).returns([invoice])
    merchant = Merchant.new({ id: 2, name: '' }, parent)
    assert_equal merchant.customers, parent.pass_customer_id_to_se([])
  end
end
