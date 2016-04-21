require_relative 'test_helper'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'

class InvoiceTest < Minitest::Test
  attr_reader :invoice, :se
  def setup
    @se = SalesEngine.from_csv({
      :invoice     => "./data/small_invoices.csv"})
    @invoice = Invoice.new({:created_at => "1988-10-18", :updated_at => "2011-04-09"}, se)
  end

  def test_we_have_a_time_obj_created
    assert_equal Time, invoice.created_at.class
  end

  def test_we_have_another_time_obj_updated
    assert_equal Time, invoice.updated_at.class
  end
end
