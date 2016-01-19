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

  def test_that_invoice_has_items
    skip
    invoice = se.invoices.find_by_id(1)
    invoice.items # => [item, item, item]
    invoice.transactions # => [transaction, transaction]
    invoice.customer # => customer
    binding.pry
  end

  def test_that_transaction_has_invoice
    skip
    transaction = se.transactions.find_by_id(1)
    transaction.invoice # => invoice
    binding.pry
  end

  def test_merchant_has_customers
    skip
    merchant = se.merchants.find_by_id(11)
    merchant.customers
    binding.pry
  end

  def test_customer_has_merchants
    skip
    customer = se.customers.find_by_id(1)
    customer.merchants
    binding.pry
  end

  def test_item_price_quantity
    invoice = se.invoices.find_by_id(1)
    invoice.item_price_quantity

    binding.pry
  end
end
