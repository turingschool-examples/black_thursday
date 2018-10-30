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


end
