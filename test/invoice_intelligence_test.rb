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

  # def test_get_total_from_all_invoice_items_for_invoice_id_returns_total
  #   setup_empty_sales_engine
  #   @se.invoice_items.create(id: 1, item_id: 2, invoice_id: 1, unit_price: BigDecimal(100_000_00), quantity: 2)
  #   @se.invoice_items.create(id: 2, item_id: 4, invoice_id: 1, unit_price: BigDecimal(10_000_00), quantity: 3)
  #   invoice = @se.invoices.create(id: 1, customer_id: 1, merchant_id: 4, status: :shipped)
  #   #doesassert @sa.get_total_from_all_invoice_items_for(invoice[0].id)
  # end


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

end
