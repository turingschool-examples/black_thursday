require './test/test_helper'
require './lib/sales_engine'
require './lib/finders'

require 'pry'


class FindersTest < Minitest::Test

  include TestSetup
  def setup
    setup_empty_sales_engine
    setup_related_data
  end
  def setup_related_data
    @se.invoices.create(id: 1, customer_id: 6, merchant_id: 1, status: :shipped)
    @se.invoices.create(id: 2, customer_id: 6, merchant_id: 1, status: :shipped)
    @se.transactions.create(id:1, invoice_id: 1, credit_card_number: 2, result: :failure, credit_card_expiration_date: Time.now)
    @se.invoice_items.create(id: 4, item_id: 5, invoice_id: 1, unit_price: BigDecimal(100_000_00), quantity: 4)
    @se.invoice_items.create(id: 4, item_id: 5, invoice_id: 2, unit_price: BigDecimal(100_000_00), quantity: 4)
    @se.merchants.create(id: 1, name: "Bob's Burgers")
    @se.items.create(id: 5, name: "burger", merchant_id: 1)
    @se.customers.create(:id => 6, :first_name => "Joan", :last_name => "Clarke", :created_at => Time.now, :updated_at => Time.now)
  end

  def test_it_can_find_invoices_from_Merchant
    merchant = @sa.merchants.all[0]
    actual = @sa.find_invoices_from(merchant)
    assert_instance_of Invoice, actual[0]
    assert_equal 2, actual.size
  end

  def test_it_can_find_invoices_from_transaction
    transaction = @sa.transactions.all[0]
    actual = @sa.find_invoices_from(transaction)
    assert_instance_of Invoice, actual[0]
    assert_equal 1, actual.size
  end

  def test_it_can_find_invoices_from_customer
    customer = @sa.customers.all[0]
    actual = @sa.find_invoices_from(customer)
    assert_instance_of Invoice, actual[0]
    assert_equal 2, actual.size
  end

  def test_it_can_find_invoices_from_invoice_item
    invoice_item = @sa.invoice_items.all[0]
    actual = @sa.find_invoices_from(invoice_item)
    assert_instance_of Invoice, actual[0]
    assert_equal 1, actual.size
  end

  def test_it_can_find_invoices_from_item
    item = @sa.items.all[0]
    actual = @sa.find_invoices_from(item)
    assert_instance_of Invoice, actual[0]
    assert_equal 2, actual.size
  end

  def test_find_from_invoice_can_find_invoice_items_from_invoice
    invoice = @sa.invoices.all[0]
    actual = @sa.find_from_invoice(invoice, 'InvoiceItem')
    assert_equal 1, actual.size
    assert_instance_of InvoiceItem, actual[0]
  end

  def test_find_from_invoice_can_find_transactions_from_invoice
    invoice = @sa.invoices.all[0]
    actual = @sa.find_from_invoice(invoice, 'Transaction')
    assert_equal 1, actual.size
    assert_instance_of Transaction, actual[0]
  end

  def test_find_from_invoice_can_find_items_from_invoice
    invoice = @sa.invoices.all[0]
    actual = @sa.find_from_invoice(invoice, 'Item')
    assert_equal 1, actual.size
    assert_instance_of Item, actual[0]
  end

  def test_find_from_invoice_can_find_customers_from_invoice
    invoice = @sa.invoices.all[0]
    actual = @sa.find_from_invoice(invoice, 'Customer')
    assert_equal 1, actual.size
    assert_instance_of Customer, actual[0]
  end

  def test_find_from_invoice_can_find_merchants_from_invoice
    invoice = @sa.invoices.all[0]
    actual = @sa.find_from_invoice(invoice, 'Merchant')
    assert_equal 1, actual.size
    assert_instance_of Merchant, actual[0]
  end



  def test_find_type_from_object_finds_right_type_of_object
    setup_related_data
    @sa.instance_variables.permutation(2) do |var_1, var_2|
      type_string = var_1.to_s
                         .delete('@')
                         .split('_')
                         .collect(&:capitalize)
                         .join[0..-2]
      repo_string = var_2.to_s.delete('@')
      object = @sa.public_send(repo_string).all[0]
      actual = @sa.find_type_from_object(type_string, object)
      assert_equal type_string, actual[0].class.to_s
    end
  end
end
