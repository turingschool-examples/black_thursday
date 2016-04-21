require_relative 'test_helper'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'

class InvoiceTest < Minitest::Test
  attr_reader :invoice, :se, :invoice_repo, :invoice2
  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/small_items.csv",
      :merchants => "./data/small_merchants.csv",
      :invoices  => "./data/small_invoices.csv"})
      @invoice_repo = @se.invoices
      @se.merchants
    @invoice = Invoice.new({:created_at => "1988-10-18", :updated_at => "2011-04-09", :status => :shipped}, se)
    @invoice2 = @invoice_repo.invoices[2]
  end

  def test_we_have_a_time_obj_created
    assert_equal Time, invoice.created_at.class
  end

  def test_we_have_another_time_obj_updated
    assert_equal Time, invoice.updated_at.class
  end

  def test_we_can_retrive_correct_merchant_from_invoice
    assert_equal "Urcase17", invoice2.merchant.name
  end
end
