require './test/test_helper'

class InvoiceItemRepositoryTest < Minitest::Test

attr_reader :invoice_item_1,
            :invoice_item_2,
            :invoice_item_3,
            :invoice_items_list,
            :iir

  def setup
    @invoice_item_1 = InvoiceItem.new(id:"1", item_id:"263519844", invoice_id:"1", quantity:"5", unit_price:"13635", created_at:"2012-03-27 14:54:09 UTC", updated_at:"2012-03-27 14:54:09 UTC")
    @invoice_item_2 = InvoiceItem.new(id:"3", item_id:"263451719", invoice_id:"1", quantity:"8", unit_price:"34873", created_at:"2012-03-27 14:54:09 UTC", updated_at:"2012-03-27 14:54:09 UTC")
    @invoice_item_3 = InvoiceItem.new(id:"5", item_id:"263515158", invoice_id:"1", quantity:"7", unit_price:"79140", created_at:"2012-03-27 14:54:09 UTC", updated_at:"2012-03-27 14:54:09 UTC")
    @invoice_items_list = [invoice_item_1, invoice_item_2, invoice_item_3]

    @iir = InvoiceItemRepository.new(invoice_items_list)
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, iir
  end

  def test_it_has_invoice_items
    assert_equal invoice_items_list, iir.invoice_items
  end

  def test_all
    assert_equal invoice_items_list, iir.all
  end

  def test_find_by_id
    assert_equal invoice_item_1, iir.find_by_id(1)
  end

  def test_find_all_by_item_id
    assert_equal [invoice_item_1], iir.find_all_by_item_id(263519844)
  end

  def test_find_all_by_invoice_id
    assert_equal invoice_items_list, iir.find_all_by_invoice_id(1)
  end

end
