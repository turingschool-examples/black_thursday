require 'minitest/autorun'
require 'minitest/pride'

require 'pry'
require './lib/invoice_item'

class InvoiceItemTest < Minitest::Test

  def setup
    @hash = {
              :id             => 6,
              :item_id        => 7,
              :invoice_id     => 8,
              :quantity       => 1,
              :unit_price     => "1200",
              :created_at     => "2016-01-11 09:34:06 UTC",
              :updated_at     => "2007-06-04 21:35:10 UTC"
    }
    @invoice_item = InvoiceItem.new(@hash)
    @big_decimal = BigDecimal(1200, 4)
  end


  def test_it_exists
   assert_instance_of InvoiceItem, @invoice_item
  end 

  def test_it_has_attributes
    assert_equal 6, @invoice_item.id
    assert_equal 7, @invoice_item.item_id
    assert_equal 8, @invoice_item.invoice_id

    assert_equal 1, @invoice_item.quantity
    assert_equal @big_decimal, @invoice_item.unit_price
    assert_equal "2016-01-11 09:34:06 UTC", @invoice_item.created_at
    assert_equal "2007-06-04 21:35:10 UTC", @invoice_item.updated_at
  end

end