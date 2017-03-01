require_relative 'test_helper.rb'
require_relative '../lib/merchant'
require_relative '../lib/sales_engine'
require_relative 'sales_engine_methods'

class MerchantTest < Minitest::Test
  include SalesEngineMethods
  attr_reader :se, :merchant

  def setup
    create_sales_engine
    @merchant = se.merchants.find_by_id(12334185)
  end

  def test_it_exists
    m = Merchant.new({:id => 5}, "engine")

    assert_instance_of Merchant, m
  end

  def test_it_knows_name
    m = Merchant.new({:name => "Turing"}, "engine")
    assert_equal "Turing", m.name
  end

  def test_it_can_find_all_instances_of_item_that_match_merch_id
    assert_instance_of Array, merchant.items
    assert_instance_of Item, merchant.items.first
    assert_equal 2, merchant.items.count
    assert_equal "DINO EGGS", merchant.items.last.name
  end

  def test_it_can_find_all_instances_of_invoice_that_match_merch_id
    assert_instance_of Array, merchant.invoices
    assert_instance_of Invoice, merchant.invoices.first
    assert_equal 10, merchant.invoices.count
    assert_equal 787, merchant.invoices.last.id
  end

  def test_it_can_find_customers_by_merchant_id
    assert_instance_of Array, merchant.customers
    assert_instance_of Customer, merchant.customers.first
    assert_equal 7, merchant.customers.count
    assert_equal "Joey", merchant.customers.first.first_name
  end

  def test_it_has_any_pending_invoices
    assert merchant.any_pending?
  end

  def test_it_knows_if_merchant_only_has_one_item
    merchant = se.merchants.find_by_id(12334105)
    assert merchant.only_one_item?
  end

  def test_it_can_find_merchant_revenue
    merchant = se.merchants.find_by_id(12334122)
    assert_instance_of BigDecimal, merchant.revenue
    assert_equal 12922.97, merchant.revenue.to_f
  end

  def test_it_knows_no_revenue_means_value_0
    merchant = se.merchants.find_by_id(12334105)
    assert_nil merchant.revenue
  end

end
