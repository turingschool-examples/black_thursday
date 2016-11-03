require_relative '../test_helper'
require_relative '../../lib/sales_engine'

class InvoiceMerchantIntegratedTest < Minitest::Test

  attr_reader :sales_engine

  def setup
    @sales_engine = SalesEngine.from_csv({
      :invoices => "./test/data_fixtures/invoices_fixture.csv",
      :merchants => "./test/data_fixtures/merchants_fixture.csv"
    })
  end
  
  def test_merchant_knows_all_its_invoices
  	merchant_id = 12334195
  	merchant = sales_engine.merchants.find_by_id(merchant_id)
  	invoices = merchant.invoices
  	assert_equal 13, invoices.length
  	assert invoices.all? {|invoice| invoice.merchant_id == merchant_id}
  end

  def test_merchant_returns_empty_array_when_merchant_has_no_invoices
  	merchant_id = 12334183
  	merchant = sales_engine.merchants.find_by_id(merchant_id)
  	invoices = merchant.invoices
  	assert_equal [], invoices
  end

  def test_invoice_knows_its_merchant
    invoice_id = 760
    invoice = sales_engine.invoices.find_by_id(invoice_id)
  	merchant = invoice.merchant
  	assert_equal invoice.merchant_id, merchant.id
  end

  def test_invoice_returns_nil_when_it_has_no_merchant
    invoice_id = 1
    invoice = sales_engine.invoices.find_by_id(invoice_id)
  	merchant = invoice.merchant
  	assert_nil merchant
  end

end