require_relative 'test_helper.rb'

require './lib/invoice.rb'

class InvoiceTest < Minitest::Test
  def setup
    @invoice = Invoice.new
  end

  def test_does_create_invoice
    assert_instance_of Invoice, @invoice
  end
end