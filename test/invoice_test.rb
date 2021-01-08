require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice'


class InvoiceTest < MiniTest::Test

  def test_it_exists
    invoice = Invoice.new

    assert_instance_of Invoice, invoice
  end
end
