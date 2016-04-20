require_relative 'test_helper'
require_relative '../lib/invoice_item'
require_relative '../lib/sales_engine'



class InvoiceItemTest < Minitest::Test

  def test_setup
    assert InvoiceItem.new.class
  end
end
