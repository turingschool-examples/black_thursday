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


end
