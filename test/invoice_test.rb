require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice'

class InvoiceTest < Minitest::Test

  def test_it_exist
    invoice = Invoice.new

    assert_instance_of Invoice, invoice
  end



end
