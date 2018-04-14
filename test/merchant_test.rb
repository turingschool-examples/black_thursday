
require_relative 'test_helper'
require_relative '../lib/merchant'
require_relative '../lib/sales_engine'

# Test class Merchant
class MerchantTest < Minitest::Test

  def setup
    @time = Time.now
    @merch = Merchant.new(
                          id:   3,
                          name: "Bill's Pencil Company"
                          )
  end

  def test_it_exists
    assert_instance_of Merchant, @merch
  end

  def test_it_has_attributes
    assert_equal 3, @merch.id
    assert_equal "Bill's Pencil Company", @merch.name
  end

  def test_it_returns_an_array_of_invoices
    se = SalesEngine.from_csv(
                              items:      './data/items.csv',
                              merchants:  './test/fixtures/merchants_fixtures.csv',
                              invoices:   './test/fixtures/invoices_fixtures.csv'
                              )
    invoice = se.invoices.find_by_id(18)
    merchant = se.merchants.find_by_id(12334839)
    invoices = merchant.invoices
    assert_instance_of Array, invoices
    assert_instance_of Invoice, invoices[0]
    assert invoices.include?(invoice)
  end

  def test_it_can_return_customers
    se = SalesEngine.from_csv(
                              items:      './data/items.csv',
                              merchants:  './test/fixtures/merchants_fixtures.csv',
                              customers:  './test/fixtures/customers_fixtures.csv',
                              invoices:   './test/fixtures/invoices_fixtures.csv'
                              )
    merchant = se.merchants.find_by_id(12334146)
    customer = se.customers.find_by_id(10)
    assert_instance_of Array, merchant.customers
    assert_instance_of Customer, merchant.customers[0]
    assert merchant.customers.include?(customer)
  end

  def test_it_returns_total_revenue

  end 
end
