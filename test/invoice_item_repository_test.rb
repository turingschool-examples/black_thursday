require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_item_repository'


class InvoiceItemRepositoryTest < Minitest::Test

  def setup
    @invoice_item1 = ([
      [id: '1'],
      [item_id: '263519844'],
      [invoice_id: '1'],
      [quantity: '5'],
      [unit_price: '13635'],
      [created_at: '2012-03-27 14:54:09 UTC'],
      [updated_at: '2012-03-27 14:54:09 UTC'],
      ])
    @invoice_item2 = ([
      [id: '9'],
      [item_id: '263529264'],
      [invoice_id: '2'],
      [quantity: '6'],
      [unit_price: '29973'],
      [created_at: '2012-03-27 14:54:09 UTC'],
      [updated_at: '2012-03-27 14:54:09 UTC'],
      ])
    @invoice_item3 = ([
      [id: '26'],
      [item_id: '263543136'],
      [invoice_id: '5'],
      [quantity: '9'],
      [unit_price: '32346'],
      [created_at: '2012-03-27 14:54:10 UTC'],
      [updated_at: '2012-03-27 14:54:10 UTC'],
      ])
      @invoice_items = [@invoice_item1, @invoice_item2, @invoice_item3]
      @iir = InvoiceItemRepository.new(@invoice_items)
  end


  def test_it_exists
    assert_instance_of InvoiceItemRepository, @iir
  end

  def test_it_holds_invoice_items
    @iir.invoice_items.all? do |invoice_item|
      assert_instance_of InvoiceItem, invoice_item
    end
    assert_instance_of InvoiceItem, @iir.invoice_items[0]
    assert_instance_of InvoiceItem, @ir.invoice_items[1]
  end

end
