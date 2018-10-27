require "./test/test_helper"

class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    @time = Time.now
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
      item_id:10,
      invoice_id:6,
      quantity:8,
      unit_price:10,
      created_at:@time,
      updated_at:@time
    }
    @ii1 = InvoiceItem.new(stats1)
    @ii2 = InvoiceItem.new(stats2)
    @invoice_items = [@ii1, @ii2]
    @iir = InvoiceItemRepository.new(@invoice_items)
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, @iir
  end
  # all - returns an array of all known InvoiceItem instances
  def test_it_can_return_all
    assert_equal [@ii1, @ii2], @iir.all
  end
  # find_by_id - returns either nil or an instance of InvoiceItem with a matching ID
  def test_it_all_by_ids
    assert_equal [], @iir.find_by_id(4646)
    assert_equal [@ii1], @iir.find_by_id(5)
  end
  # find_all_by_item_id - returns either [] or one or more matches which have a matching item ID
  def test_it_can_find_all_by_id
    assert_equal [], @iir.find_all_by_item_id(3737373)
    assert_equal [@ii1, @ii2], @iir.find_all_by_item_id(10)
  end
  # find_all_by_invoice_id - returns either [] or one or more matches which have a matching invoice ID
  def test_it_can_find_item_by_invoice_id
    assert_equal [], @iir.find_all_by_invoice_id(151)
    assert_equal [@ii1], @iir.find_all_by_invoice_id(15)
  end
  # create(attributes) - create a new InvoiceItem instance with the provided attributes. The new InvoiceItem’s id should be the current highest InvoiceItem id plus 1.
  def test_it_can_create_invoice_items
    ii3 = @iir.create({
      item_id:10,
      invoice_id:6,
      quantity:8,
      unit_price:10,
      created_at:@time,
      updated_at:@time
    })
    assert_equal 6, ii3.id
    assert_equal 10, ii3.item_id
  end
  # update(id, attribute) - update the InvoiceItem instance with the corresponding id with the provided attributes. Only the invoice_item’s quantity and unit_price can be updated. This method will also change the invoice_item’s updated_at attribute to the current time.
  def test_it_can_update_invoice_items
    @iir.update({
      quantity:8,
      unit_price:10,
      updated_at:@time #should be time.now
    })
  end
  # delete(id) - delete the InvoiceItem instance with the corresponding id
  def test_it_can_delete_invoice_items
    @iir.delete(5)

    refute @iir.all.include? @ii1 
  end
end
