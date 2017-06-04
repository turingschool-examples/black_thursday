require 'pry'

require 'bigdecimal'
require 'time'
require_relative './test_helper'
require_relative '../lib/invoice_item'
require_relative '../lib/sales_engine'

class InvoiceItemTest < Minitest::Test

  def test_if_create_class
    ii = InvoiceItem.new

    assert_instance_of InvoiceItem, ii
  end


end
