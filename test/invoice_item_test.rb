require './test/test_helper'

class InvoiceItemTest < Minitest::Test

  def test_it_exists
    assert_instance_of InvoiceItem, InvoiceItem.new({})
  end
end
