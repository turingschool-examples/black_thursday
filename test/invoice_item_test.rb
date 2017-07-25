require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_item'

class InvoiceItemTest < Minitest::Test

  def test_it_exist
    invoice_item = InvoiceItem.new

    assert_instance_of InvoiceItem, invoice_item
  end

end
