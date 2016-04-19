require './test/test_helper'
require './lib/sales_engine'
require './lib/invoice_item'


class InvoiceItemTest < Minitest::Test

  def test_case_name
    assert InvoiceItem.new.class
  end
end
