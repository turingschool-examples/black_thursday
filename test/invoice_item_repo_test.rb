require "./test/test_helper"

class InvoiceItemRepoTest < Minitest::Test
  def setup
    stats1 = {
      id:5,
      item_id:10,
      invoice_id:15,
      quantity:20,
      unit_price:25,
      created_at:@time,
      updated_at:@time
    }
    stats2 = {
      id:2,
      item_id:4,
      invoice_id:6,
      quantity:8,
      unit_price:10,
      created_at:@time,
      updated_at:@time
    }

    @ii1 = InvoiceItem.new(stats1)
    @ii2 = InvoiceItem.new(stats2)
    @invoice_items = [@ii1, @ii2]
    @iir = InvoiceItemRepository.new(@invoiceitems)
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, @iir
  end
  # all - returns an array of all known InvoiceItem instances
  def test_it_can_return_all
    assert_equal [@ii1, @ii2], @iir.all
  end

  # find_by_id - returns either nil or an instance of InvoiceItem with a matching ID
  # find_all_by_item_id - returns either [] or one or more matches which have a matching item ID
  # find_all_by_invoice_id - returns either [] or one or more matches which have a matching invoice ID
  # create(attributes) - create a new InvoiceItem instance with the provided attributes. The new InvoiceItem’s id should be the current highest InvoiceItem id plus 1.
  # update(id, attribute) - update the InvoiceItem instance with the corresponding id with the provided attributes. Only the invoice_item’s quantity and unit_price can be updated. This method will also change the invoice_item’s updated_at attribute to the current time.
  # delete(id) - delete the InvoiceItem instance with the corresponding id
end
