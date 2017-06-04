require 'pry'

require 'bigdecimal'
require 'time'
require_relative './test_helper'
require_relative '../lib/invoice_item'
require_relative '../lib/sales_engine'

class InvoiceItemTest < Minitest::Test

  def setup

    @ii1 = InvoiceItem.new({"id"          => '1',
                            "item_id"     => '263519844',
                            "invoice_id"  => '1',
                            "quantity"    => '5',
                            "unit_price"  => '13635',
                            "created_at"  => '2012-03-27 14:54:09 UTC',
                            "updated_at"  => '2012-03-27 14:54:09 UTC'
                           })

  end

  def test_if_create_class

    assert_instance_of InvoiceItem, @ii1
  end

  def test_defaulit_attributes_and_format
    assert_equal 1, @ii1.id
    assert_equal 263519844, @ii1.item_id
    assert_equal 1, @ii1.invoice_id
    assert_equal 5, @ii1.quantity
    assert_equal 0.13635E3, @ii1.unit_price
    assert @ii1.created_at
    assert @ii1.updated_at

  end


end
