require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice'

class InvoiceTest < MiniTest::Test

  def test_invoice_exists
    invoice = Invoice.new("stuff")

    assert_instance_of Invoice, invoice
  end

end
