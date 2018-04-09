require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice.rb'

class InvoiceTest < Minitest::Test
  def test_exists
    invoice = Invoice.new

    assert_instance_of Invoice, invoice
  end
end
