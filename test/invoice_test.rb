require './test/test_helper'
require './lib/sales_engine'
require './lib/invoice'


class InvoiceTest < Minitest::Test

  def test_setup
    assert Invoice.new.class
  end
end
