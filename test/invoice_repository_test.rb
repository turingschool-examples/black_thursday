require_relative 'test_helper'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/transaction_repository'
require_relative '../lib/customer_repository'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    @data = {
      items:     './test/fixtures/items_truncated.csv',
      merchants: './test/fixtures/merchants_truncated.csv',
      invoices: './test/fixtures/invoices_truncated.csv',
      invoice_items: './test/fixtures/invoice_items_truncated.csv',
      transactions: './test/fixtures/transactions_truncated.csv',
      customers: './test/fixtures/customers_truncated.csv'
    }
    @ir = InvoiceRepository.new(@data, mock('salesengine'))
  end

  def test_all_returns_array_of_invoice_instances
    invoices = @ir.all

    all_invoices = invoices.all? do |invoice|
      invoice.class == Invoice
    end

    assert all_invoices
  end

  def test_find_by_id_returns_nil_if_no_matching_id
    assert_nil @ir.find_by_id(200)
  end

  def test_find_by_id_returns_invoice_instance_with_matching_id
    invoice = @ir.find_by_id(2)

    assert_equal 2, invoice.id
  end

  def test_find_all_by_customer_id_returns_all_invoice_instances_with_matching_id
    invoices = @ir.find_all_by_customer_id(5)

    all_match_customer_id = invoices.all? do |invoice|
      invoice.customer_id == 5
    end

    assert all_match_customer_id
  end

  def test_find_all_by_customer_id_returns_empty_array_if_no_matching_id
    assert_equal [], @ir.find_all_by_customer_id(500)
  end

  def test_find_all_by_merchant_id_returns_all_invoice_instances_with_matching_id
    invoices = @ir.find_all_by_merchant_id(12334753)

    all_match_merchant_id = invoices.all? do |invoice|
      invoice.merchant_id == 12334753
    end

    assert all_match_merchant_id
  end

  def test_find_all_by_merchant_id_returns_empty_array_if_no_matching_id
    assert_equal [], @ir.find_all_by_merchant_id(11111111)
  end

  def test_find_all_by_status_returns_all_invoice_instances_with_matching_status
    invoices = @ir.find_all_by_status(:shipped)

    all_succesful = invoices.all? do |invoice|
      invoice.status == :shipped
    end

    assert all_succesful
  end

  def test_find_all_by_status_returns_empty_array_if_no_matching_status
    assert_equal [], @ir.find_all_by_status("shiped")
  end

  def test_find_items_by_invoice_id_returns_all_items_with_invoice_id
    item = mock('item')
    salesengine = stub(:find_item_by_item_id => item)
    ir = InvoiceRepository.new(@data, salesengine)

    assert_equal [item, item, item], ir.find_items_by_invoice_id(25)
  end

  def test_it_finds_transactions_by_invoice_id
    transactions = @ir.find_transactions_by_invoice_id(7)

    assert_equal 2, transactions.count
    assert_instance_of Transaction, transactions.first
  end

  def test_it_finds_customer_by_customer_id
    customer = @ir.find_customer_by_customer_id(3)

    assert_instance_of Customer, customer
    assert_equal 3, customer.id
  end

  def test_it_can_find_invoice_items_by_invoice_id
    invoice_items = @ir.find_invoice_items_by_invoice_id(25)

    all_match_invoice_id = invoice_items.all? do |invoice_item|
      invoice_item.invoice_id == 25 && invoice_item.class == InvoiceItem
    end

    assert_equal 3, invoice_items.count
    assert all_match_invoice_id
  end

  def test_find_all_by_date_finds_all_invoices_created_on_a_given_date
    date = Time.parse("2010-09-17")
    invoices = @ir.find_all_by_date(date)

    all_created_on_date = invoices.all? do |invoice|
      invoice.created_at == date
    end

    assert_equal 2, invoices.count
    assert all_created_on_date
  end
end
