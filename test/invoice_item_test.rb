require './test/test_helper'
require './lib/invoice_item'
require './lib/sales_engine'



class InvoiceItemTest < Minitest::Test

  def test_setup
    assert InvoiceItem.new.class
  end
end
