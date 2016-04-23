require_relative 'test_helper'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'

class InvoiceTest < Minitest::Test
  attr_reader :invoice, :se, :invoice_repo, :invoice2, :invoice3
  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/small_items.csv",
      :merchants => "./data/small_merchants.csv",
      :invoice_items => "./data/small_invoice_items.csv",
      :customers => "./data/small_customers_items.csv",
      :transactions => "./data/small_transactions.csv",
      :invoices  => "./data/small_invoices.csv"})
    @invoice_repo = @se.invoices
    @se.merchants
    @se.invoice_items
    @invoice = Invoice.new({
      :created_at => "1988-10-18",
      :updated_at => "2011-04-09",
      :status => :shipped,
      :customer_id => 1,
      :id => 1}, se)
    @invoice2 = Invoice.new({:id => 2, :status => :shipped}, se)
    @invoice3 = @invoice_repo.invoices[2]

  end

  def test_we_have_a_time_obj_created
    assert_equal Time, invoice.created_at.class
  end

  def test_we_have_another_time_obj_updated
    assert_equal Time, invoice.updated_at.class
  end

  def test_we_can_retrive_correct_merchant_from_invoice
    assert_equal "Urcase17", invoice3.merchant.name
  end

  def test_we_can_retrieve_all_items_on_an_invoice
    assert_equal 8, invoice.items.length
  end

  def test_we_can_retrieve_correct_item
    assert_equal 263519844, invoice.items[0].item_id
  end

  def test_we_can_retrieve_correct_secondary_item
    assert_equal 263454779, invoice.items[1].item_id
  end

  def test_we_can_retrieve_all_transactions_for_invoice
    skip
    assert_equal 2, invoice.transactions.length
  end

  def test_transactions_returns_array
    skip
    assert_equal Array, invoice.transactions.class
  end

  def test_transactions_returns_array_of_transaction_objects
    skip
    assert_equal Transaction, invoice.transactions[0].class
  end

  def test_we_can_retrieve_customer_object
    skip
    assert_equal Customer, invoice.customer.class
  end

  def test_we_can_retrieve_correct_customer
    skip
    assert_equal "Joey", invoice.customer.first_name
  end

  def is_paid_in_full_returns_true_when_multiple_transactions
    skip
    assert_equal true, invoice.is_paid_in_full?
  end

  def is_paid_in_full_returns_false_when_no_success
    skip
    assert_equal false, invoice2.is_paid_in_full?
  end

  def total_returns_correct_total_for_multi_item_invoice
    skip
    assert_equal 1835.56, invoice2.total
  end

end
