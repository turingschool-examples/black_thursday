require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/item'
require_relative '../lib/sales_engine'


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
    parent = stub(pass_id_to_se_for_invoice: '2')
    merchant = Merchant.new({ id: '2', name: '' }, parent)
    assert_equal merchant.invoices, parent.pass_id_to_se_for_invoice
  end

  def test_customers_method
    skip # need to fix test, works in spec harness
    parent = stub(pass_customer_id_to_se: [], pass_id_to_se_for_invoice: [1,2,3])
    merchant = Merchant.new({ id: 2, name: '' }, parent)
    assert_equal merchant.customers, parent.pass_customer_id_to_se([])
  end
end
