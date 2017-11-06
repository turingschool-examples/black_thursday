require_relative './test_helper'
require 'bigdecimal'
require './lib/sales_analyst'

class CustomerAnalystTest < Minitest::Test
  attr_reader :se,
              :sa

  def setup
    @se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => './data/merchants.csv',
      :invoices => './data/invoices.csv',
      :customers => './data/customers.csv',
      :invoice_items => './data/invoice_items.csv',
      :transactions => './data/transactions.csv'
    })
    @sa = SalesAnalyst.new(se)
  end

  def test_customer_analyst_top_buyers
    two = sa.top_buyers(2)
    twenty = sa.top_buyers

    assert_instance_of Customer, two.first
    assert_instance_of Customer, two.last
    assert_equal 2, two.count
    assert_equal 20, twenty.count
  end

  def test_top_merchant_for_customer
    merchant_1 = sa.top_merchant_for_customer(297)
    merchant_2 = sa.top_merchant_for_customer(413)

    assert_equal 'KamLandSoapShop', merchant_1.name
    assert_equal 'byMarieinLondon', merchant_2.name
  end

  def test_one_time_buyers
    one_time_buyers = sa.one_time_buyers

    assert_instance_of Customer, one_time_buyers.first
    assert_equal 150, one_time_buyers.count
    assert_equal 1, one_time_buyers.first.fully_paid_invoices.length
  end

  def test_one_time_buyers_top_items
    top_item = sa.one_time_buyers_top_items

    assert_equal 1, top_item.length
    assert_equal [263518806], [top_item.first.id]
    assert_instance_of Item, top_item.first
  end

  def test_items_bought_in_year
    items = sa.items_bought_in_year(1, 2009)

    assert_equal 16, items.count
    assert_instance_of Item, items.first
    assert_equal 263519844, items.first.id
    assert items.first.name.start_with?('Catnip Pillow')
  end

  def test_highest_volume_items
    items = sa.highest_volume_items(1)

    assert_equal 1, items.count
    assert_equal 263519844, items.first.id
  end

  def test_customers_with_unpaid_invoices
    customers = sa.customers_with_unpaid_invoices

    assert_equal 786, customers.count
    assert_equal 1, customers.first.id
  end

  def test_best_invoice_by_revenue
    invoice = sa.best_invoice_by_revenue

    assert_equal 3394, invoice.id
    assert_equal 47877.97, invoice.total
  end

  def test_best_invoice_by_quantity
    invoice = sa.best_invoice_by_quantity

    assert_equal 1281, invoice.id
  end
end
