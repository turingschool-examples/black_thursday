require 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require './lib/invoice_item'

class InvoiceItemTest < Minitest::Test

  def test_it_exists
    i = InvoiceItem.new(1)
    assert i
    assert_instance_of InvoiceItem, i
  end


end
