require './test/test_helper'
require './lib/merchant'
require './lib/sales_engine'

class MerchantTest < Minitest::Test
  include SalesEngineTestSetup

  def setup
    super
  end

  def test_it_exists
    m = Merchant.new({:id => 5, :name => "Turing School"})
    assert_instance_of Merchant, m
  end

  def test_merchant_id
    m = Merchant.new({:id => 5, :name => "Turing School"})
    assert_equal 5, m.id
  end

  def test_merchant_name
    m = Merchant.new({:id => 5, :name => "Turing School"})
    assert_equal "Turing School", m.name
  end

  def test_find_items_by_merchant_id
    merchant = @se.merchants.find_by_id(12334783)

    assert_instance_of Array, merchant.items
    assert_equal 4, merchant.items.count
    assert_equal "Freedom", merchant.items.first.name
  end

  def test_invoices_attached_to_merchant
    merchant = @se.merchants.find_by_id(12334159)

    assert_instance_of Array, merchant.invoices
    assert_equal 13, merchant.invoices.count
    assert_equal 44, merchant.invoices.first.customer_id
  end

  def test_customers_attached_to_merchant
    merchant = @se.merchants.find_by_id(12335938)

    assert_instance_of Array, merchant.customers
    assert_instance_of Customer, merchant.customers.first
  end
end
