require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_item'
require 'time'

class ItemInvoiceTest < Minitest::Test
  def test_exists
    ii = ItemInvoice.new({:id => 1,
                          :item_id => 263519844,
                          :invoice_id => 1,
                          :quantity => 5,
                          :unit_price => 13635,
                          :created_at => Time.now,
                          :updated_at => Time.now
                          })
    assert_instance_of ItemInvoice, ii
  end
end
