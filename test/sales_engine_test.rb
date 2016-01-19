require_relative './../lib/sales_engine'
require_relative 'spec_helper'
require          'pry'
require          'minitest/autorun'
require          'minitest/pride'


class SalesEngineTest < Minitest::Test
  attr_reader :se

  def test_that_class_exist
    assert SalesEngine
  end

  def setup
    @se = SalesEngine.from_csv({
                              :items     => "./data/sample/items_sample.csv",
                              :merchants => "./data/sample/merchants_sample.csv",
                              :invoices  => "./data/sample/invoice_sample.csv",
                              :invoice_items => "./data/sample/invoice_items_samples.csv",
                              :transactions  => "./data/sample/transaction_sample.csv",
                              :customers    => "./data/customers.csv"
                              })

  end

  def test_that_class_has_an_item_repository_instance
    assert_equal ItemRepository, se.items.class
  end

  def test_that_class_has_a_merchant_repository_instance
    assert_equal MerchantRepository, se.merchants.class
  end

  def test_that_will_merchant_and_items_relationship_works
    merchant = se.merchants.find_by_id("11")
    assert_equal ["First Item Name"], merchant.items.map(&:name)

    item = se.items.find_by_id("1111")
    assert_equal "Store One", item.merchant.name
  end

  def test_that_will_merchant_and_items_relationship_works_on_getting_the_unit_prices
    merchant = se.merchants.find_by_id(22)

    assert_equal ["Second Item Name", "Third Item Name", "Fourth Item Name"], merchant.items.map(&:name)
    assert_equal [222.0, 33.0, 444.0], merchant.items.map(&:unit_price).map{ |x| x.to_f }
  end

  def test_that_merchant_has_invoices
    merchant = se.merchants.find_by_id(22)

    assert_equal [5, 6], merchant.invoices.map(&:id)
  end

  def test_that_invoices_has_a_merchant
    invoice = se.invoices.find_by_id(1)

    assert_equal 11, invoice.merchant.id
  end

  def test_that_an_invoice_has_information_on_its_item_transaction_and_customer
    invoice = se.invoices.find_by_id(1)

    assert_equal               [Item], invoice.items.map(&:class)
    assert_equal  ["First Item Name"], invoice.items.map(&:name)

    assert_equal        [Transaction], invoice.transactions.map(&:class)
    assert_equal          ["success"], invoice.transactions.map(&:result)

    full_name = invoice.customer.first_name + " " + invoice.customer.last_name

    assert_equal              Customer, invoice.customer.class
    assert_equal       "Joey Ondricka", full_name
  end

  def test_that_a_transaction_has_invoice_information
    transaction = se.transactions.find_by_id(1)

    assert_equal  Invoice, transaction.invoice.class
    assert_equal        1, transaction.invoice.customer_id
    assert_equal :pending,  transaction.invoice.status
  end

  def test_merchant_has_customer_information
    merchant = se.merchants.find_by_id(11)

    assert_equal                       [Customer], merchant.customers.map(&:class)
    assert_equal                         ["Joey"], merchant.customers.map(&:first_name)
  end

  def test_customer_has_merchants
    customer = se.customers.find_by_id(1)

    assert_equal [11, 11, 11, 11, 22, 22, 33, 44], customer.merchants.map(&:id)
    assert_equal      Merchant, customer.merchants[0].class
    assert_equal   "Store One", customer.merchants.map(&:name)[0]
  end

  def test_total_gets_both_the_item_price_and_quantity_and_adds_it_up
    invoice = se.invoices.find_by_id(1)

    assert_equal      true, invoice.is_paid_in_full?
    assert_equal    681.75, invoice.total.to_f
    assert_equal BigDecimal, invoice.total.class
  end
end
