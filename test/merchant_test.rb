require_relative 'test_helper'
require_relative '../lib/merchant'
require_relative '../lib/sales_engine'

class MerchantTest < Minitest::Test
  def setup
    data = { id: 5, name: 'Turing School', created_at: "2018-02-02 14:37:20 -0700" }
    @data_se = {
      items:         './test/fixtures/items_sample.csv',
      merchants:     './test/fixtures/merchants_sample.csv',
      invoices:      './test/fixtures/invoices_sample.csv',
      invoice_items: './test/fixtures/invoice_items_sample.csv',
      transactions:  './test/fixtures/transactions_sample.csv',
      customers:     './test/fixtures/customers_sample.csv'
      }
    @merchant = Merchant.new(data)
  end

  def test_it_exists
    assert_instance_of Merchant, @merchant
  end

  def test_it_returns_an_id
    assert_equal 5, @merchant.id
  end

  def test_it_returns_a_different_id
    merchant = Merchant.new({ id: 23, name: 'Turing School', created_at: "2018-02-02 14:37:20 -0700" })

    assert_equal 23, merchant.id
  end

  def test_it_returns_a_name
    assert_equal 'Turing School', @merchant.name
  end

  def test_it_returns_a_different_name
    merchant = Merchant.new({ id: 5, name: 'Yale Business School', created_at: "2018-02-02 14:37:20 -0700" })

    assert_equal 'Yale Business School', merchant.name
  end

  def test_if_it_returns_all_items_for_a_merchant
    sales_engine = SalesEngine.new(@data_se)
    id = 12_334_185
    merchant = sales_engine.merchants.find_by_id(id)

    assert merchant.items.all? do |item|
      item.merchant_id == id
    end
    assert merchant.items.class == Array
    assert merchant.items.first.class == Item
    assert_equal 3, merchant.items.length
  end

  def test_if_it_returns_all_invoices_for_a_merchant
    sales_engine = SalesEngine.new(@data_se)
    id = 12_334_141
    merchant = sales_engine.merchants.find_by_id(id)

    assert merchant.invoices.all? do |invoice|
      invoice.merchant_id == id
    end
    assert merchant.invoices.class == Array
    assert merchant.invoices.first.class == Invoice
    assert_equal 9, merchant.invoices.length
  end

  def test_if_it_returns_all_customers_for_a_merchant
    sales_engine = SalesEngine.new(@data_se)
    id = 12_334_141
    merchant = sales_engine.merchants.find_by_id(id)

    assert merchant.customers.first.class == Customer
    assert_equal 2, merchant.customers.length
  end

  def test_if_it_returns_revenue_for_invoices_paid_in_full
    sales_engine = SalesEngine.new(@data_se)
    id = 12_334_141
    merchant = sales_engine.merchants.find_by_id(id)

    assert_equal 0.438056e5, merchant.revenue
  end
end
