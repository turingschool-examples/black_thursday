require_relative 'test_helper'
require_relative '../lib/invoice_item_repository.rb'
require 'pry'

class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    invoice_item_1 = InvoiceItem.new({
      id: 2345,
      item_id: 112,
      invoice_id: 522,
      unit_price: 84787,
      quantity: 5,
      created_at: "2012-03-27 14:54:35 UTC",
      updated_at: "2012-03-27 14:54:35 UTC"
      })
    invoice_item_2 = InvoiceItem.new({
      id: 2346,
      item_id: 113,
      invoice_id: 316,
      unit_price: 90000,
      quantity: 2,
      created_at: "2012-03-27 14:54:35 UTC",
      updated_at: "2012-03-27 14:54:35 UTC"
      })
    invoice_item_3 = InvoiceItem.new({
      id: 2347,
      item_id: 114,
      invoice_id: 222,
      unit_price: 100000,
      quantity: 1,
      created_at: "2012-03-27 14:54:35 UTC",
      updated_at: "2012-03-27 14:54:35 UTC"
      })
    invoice_item_4 = InvoiceItem.new({
      id: 2348,
      item_id: 115,
      invoice_id: 453,
      unit_price: 25397,
      quantity: 7,
      created_at: "2012-03-27 14:54:35 UTC",
      updated_at: "2012-03-27 14:54:35 UTC"
      })
    invoice_item_5 = InvoiceItem.new({
      id: 2349,
      item_id: 116,
      invoice_id: 846,
      unit_price: 11000,
      quantity: 5,
      created_at: "2012-03-27 14:54:35 UTC",
      updated_at: "2012-03-27 14:54:35 UTC"
      })

    invoice_items = [invoice_item_1, invoice_item_2, invoice_item_3, invoice_item_4, invoice_item_5]
    @invoice_item_repository = InvoiceItemRepository.new(invoice_items)
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, @invoice_item_repository
  end

  def test_it_can_hold_items
    assert_instance_of Array, @invoice_item_repository.list
  end

  def test_its_holding_items
    assert_instance_of InvoiceItem, @invoice_item_repository.list[0]
    assert_instance_of InvoiceItem, @invoice_item_repository.list[3]
  end

  def test_it_can_return_items_using_all
    assert_instance_of InvoiceItem, @invoice_item_repository.all[4]
    assert_instance_of InvoiceItem, @invoice_item_repository.all[1]
  end

  def test_it_can_find_by_id
    expected = @invoice_item_repository.list[0]
    actual = @invoice_item_repository.find_by_id(2345)
    assert_equal expected, actual
  end

  def test_it_can_find_by_item_id
    expected = 1
    actual = @invoice_item_repository.find_all_by_item_id(112).count
    assert_equal expected, actual
  end

  def test_it_can_find_by_invoice_id
    expected = 1
    actual = @invoice_item_repository.find_all_by_invoice_id(222).count
    assert_equal expected, actual
  end

  def test_it_create_new_item_with_attributes
    attributes = {
      item_id: 7,
      invoice_id: 8,
      unit_price: BigDecimal.new(10.99, 4),
      quantity: 1,
      created_at: Time.now,
      updated_at: Time.now
      }
    new_item_added = @invoice_item_repository.create(attributes)
    expected = @invoice_item_repository.list[-1]
    actual = new_item_added
    assert_equal expected, actual
  end

  def test_it_can_update_attributes
    new_attributes = {
      item_id: 7,
      invoice_id: 8,
      unit_price: 1099,
      quantity: 1,
      created_at: Time.now,
      updated_at: Time.now
      }
    updated_attributes = {
      quantity: 13,
      unit_price: 12.99
      }
    @invoice_item_repository.create(new_attributes)
    new_invoice_item = @invoice_item_repository.list.last

    assert_equal BigDecimal.new(10.99, 4), new_invoice_item.unit_price

    @invoice_item_repository.update(2350, updated_attributes)
    changed_invoice_item = @invoice_item_repository.list.last

    assert_equal BigDecimal.new(12.99, 4), changed_invoice_item.unit_price
    assert_equal 13, changed_invoice_item.quantity

    assert_equal new_invoice_item.id, changed_invoice_item.id
  end

  def test_it_can_delete_invoice_item
    assert_equal @invoice_item_repository.list[0], @invoice_item_repository.find_by_id(2345)

    @invoice_item_repository.delete(2345)
    assert_nil @invoice_item_repository.find_by_id(2345)
  end
end
