require './test/test_helper'
require './lib/invoice'
require './lib/sales_engine'



class InvoiceTest < Minitest::Test

  def test_setup
    assert Invoice.new.class
  end
end
