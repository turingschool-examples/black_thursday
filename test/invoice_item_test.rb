require_relative 'test_helper'
require_relative '../lib/invoice_item'

class InvoiceItemTest < Minitest::Test
  def test_it_exists
    inv_item = InvoiceItem.new({:id => "5", :item_id => "263515158", :invoice_id => "1", :quantity => "7", :unit_price => "79140",  :created_at => "2012-03-27 14:54:09 UTC",:updated_at => "2012-03-27 14:54:09 UTC"})

    assert_instance_of InvoiceItem, inv_item
  end
  
end
