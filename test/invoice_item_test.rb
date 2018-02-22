require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/invoice_item'
require_relative '../lib/sales_engine'
require 'bigdecimal'
require 'pry'


class InvoiceItemTest < Minitest::Test
  def setup
    @ii = InvoiceItem.new({ :id => 6,
                            :item_id => 7,
                            :invoice_id => 8,
                            :quantity => 1,
                            :unit_price => BigDecimal.new(10.99, 4),
                            :created_at => "2012-03-27 14:54:09 UTC",
                            :updated_at => "2012-03-27 14:54:09 UTC"},
                          'parent' )
  end

  def test_it_exists
    assert_instance_of InvoiceItem, @ii
  end

  def test_it_has_attributes
    assert_equal 6, @ii.id
    assert_equal 7, @ii.item_id
    assert_equal 8, @ii.invoice_id
  end


end
