require_relative 'test_helper'
require_relative './test_setup'

require './lib/sales_engine'
require './test/test_data'

class InvoiceIntelligenceTest < Minitest::Test
  include TestData, TestSetup

  def test_invoice_has_no_transactions
    setup_empty_sales_engine
    invoice = @se.invoices.create(id: 1, customer_id: 1, merchant_id: 4, status: :shipped)
    assert @sa.invoice_has_no_transactions?(invoice[0].id)
  end

  def test_invoice_paid_in_full_can_return_true
    setup_empty_sales_engine
    invoice = @se.invoices.create(id: 1, customer_id: 1, merchant_id: 4, status: :shipped)
    @se.transactions.create(id:1, invoice_id: 1, credit_card_number: 2, result: :success, credit_card_expiration_date: Time.now)
    assert @sa.invoice_paid_in_full?(invoice[0].id)
  end

  def test_all_transactions_successful_for_invoice_id_returns_true
    setup_empty_sales_engine
    invoice = @se.invoices.create(id: 1, customer_id: 1, merchant_id: 4, status: :shipped)
    @se.transactions.create(id:1, invoice_id: 1, credit_card_number: 2, result: :success, credit_card_expiration_date: Time.now)
    assert @sa.all_transactions_successful_for?(invoice[0].id)
  end

  def test_all_transactions_successful_for_invoice_id_returns_false_when_one_is_unsuccessful
    setup_empty_sales_engine
    invoice = @se.invoices.create(id: 1, customer_id: 1, merchant_id: 4, status: :shipped)
    @se.transactions.create(id:1, invoice_id: 1, credit_card_number: 2, result: :success, credit_card_expiration_date: Time.now)
    @se.transactions.create(id:1, invoice_id: 1, credit_card_number: 2, result: :failure, credit_card_expiration_date: Time.now)
    refute @sa.all_transactions_successful_for?(invoice[0].id)
  end

  def test_get_item_count_for_invoice_id
    setup_empty_sales_engine
    invoice = @se.invoices.create(id: 1, customer_id: 1, merchant_id: 4, status: :shipped)
    @se.invoice_items.create(id: 1, item_id: 2, invoice_id: 1, unit_price: BigDecimal(100_000_00), quantity: 1)
    @se.invoice_items.create(id: 2, item_id: 3, invoice_id: 1, unit_price: BigDecimal(100_000_00), quantity: 2)
    @se.invoice_items.create(id: 3, item_id: 4, invoice_id: 1, unit_price: BigDecimal(100_000_00), quantity: 3)
    @se.invoice_items.create(id: 4, item_id: 5, invoice_id: 1, unit_price: BigDecimal(100_000_00), quantity: 4)
    assert_equal 10, @sa.get_item_count_for(invoice[0].id)
  end

  def test_best_invoice_by_quantity
    setup_empty_sales_engine
    @se.invoices.create(id: 1, customer_id: 1, merchant_id: 4, status: :shipped)
    @se.invoices.create(id: 2, customer_id: 1, merchant_id: 4, status: :shipped)
    @se.transactions.create(id:1, invoice_id: 1, credit_card_number: 2, result: :success, credit_card_expiration_date: Time.now)
    @se.transactions.create(id:1, invoice_id: 2, credit_card_number: 2, result: :success, credit_card_expiration_date: Time.now)
    @se.invoice_items.create(id: 1, item_id: 2, invoice_id: 2, unit_price: BigDecimal(100_000_00), quantity: 1)
    @se.invoice_items.create(id: 2, item_id: 3, invoice_id: 2, unit_price: BigDecimal(100_000_00), quantity: 2)
    @se.invoice_items.create(id: 3, item_id: 4, invoice_id: 1, unit_price: BigDecimal(100_000_00), quantity: 3)
    @se.invoice_items.create(id: 4, item_id: 5, invoice_id: 1, unit_price: BigDecimal(100_000_00), quantity: 4)
    actual = @sa.best_invoice_by_quantity
    assert_instance_of Invoice, actual
    assert_equal 1, actual.id
  end

  def test_best_invoice_by_revenue
    setup_empty_sales_engine
    @se.invoices.create(id: 1, customer_id: 1, merchant_id: 4, status: :shipped)
    @se.invoices.create(id: 2, customer_id: 1, merchant_id: 4, status: :shipped)
    @se.transactions.create(id:1, invoice_id: 1, credit_card_number: 2, result: :success, credit_card_expiration_date: Time.now)
    @se.transactions.create(id:1, invoice_id: 2, credit_card_number: 2, result: :success, credit_card_expiration_date: Time.now)
    @se.invoice_items.create(id: 1, item_id: 2, invoice_id: 2, unit_price: BigDecimal(100_000_00), quantity: 1)
    @se.invoice_items.create(id: 2, item_id: 3, invoice_id: 2, unit_price: BigDecimal(100_000_00), quantity: 2)
    @se.invoice_items.create(id: 3, item_id: 4, invoice_id: 1, unit_price: BigDecimal(1), quantity: 3)
    @se.invoice_items.create(id: 4, item_id: 5, invoice_id: 1, unit_price: BigDecimal(20000), quantity: 4)
    actual = @sa.best_invoice_by_revenue
    assert_instance_of Invoice, actual
    assert_equal 2, actual.id
  end

  def test_quantity_of_invoice
    setup_empty_sales_engine
    invoice = @se.invoices.create(id: 2, customer_id: 1, merchant_id: 4, status: :shipped)
    @se.invoice_items.create(id: 1, item_id: 2, invoice_id: 2, unit_price: BigDecimal(100_000_00), quantity: 1)
    @se.invoice_items.create(id: 2, item_id: 3, invoice_id: 2, unit_price: BigDecimal(100_000_00), quantity: 2)
    @se.invoice_items.create(id: 4, item_id: 5, invoice_id: 2, unit_price: BigDecimal(20000), quantity: 4)
    assert_equal 7, @sa.quantity_of_invoice(invoice[0])
  end

end
