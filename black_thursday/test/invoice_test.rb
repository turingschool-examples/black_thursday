require_relative 'test_helper'
require 'time'
require_relative './../lib/invoice'
require_relative './../lib/invoice_repository'
require_relative './../lib/sales_engine'

class InvoiceTest < Minitest::Test
  def test_it_exists
    invoice = Invoice.new

    assert_instance_of Invoice, invoice
  end
end
