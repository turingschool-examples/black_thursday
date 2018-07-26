require_relative 'test_helper'
require_relative '../lib/invoice_item_repository.rb'
require 'pry'

class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    @invoice_item_repository = InvoiceItemRepository.new("./data/invoice_items.csv")
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, @invoice_item_repository
  end

  def test_it_can_hold_items
    assert_instance_of Array, @invoice_item_repository.invoice_items
  end

  def test_its_holding_items
    # skip
    assert_instance_of InvoiceItem, @invoice_item_repository.invoice_items[0]
    assert_instance_of InvoiceItem, @invoice_item_repository.invoice_items[25]
  end

  def test_it_can_return_items_using_all
    assert_instance_of InvoiceItem, @invoice_item_repository.all[5]
    assert_instance_of InvoiceItem, @invoice_item_repository.all[97]
  end

  def test_it_can_find_by_id
    expected = @invoice_item_repository.invoice_items[0]
    actual = @invoice_item_repository.find_by_id(1)
    assert_equal expected, actual
  end

  def test_it_can_find_by_item_id
    expected = 164
    actual = @invoice_item_repository.find_all_by_item_id(263519844).count
    assert_equal expected, actual
  end

  def test_it_can_find_by_invoice_id
    expected = 8
    actual = @invoice_item_repository.find_all_by_invoice_id(1).count
    assert_equal expected, actual
  end

  def test_it_create_new_item_with_attributes
    skip
    attributes = {
          :item_id => 7,
          :invoice_id => 8,
          :quantity => 1,
          :unit_price => BigDecimal.new(10.99, 4),
          :created_at => Time.now,
          :updated_at => Time.now
        }
    new_item_added = @invoice_item_repository.create(attributes)
    expected = @invoice_item_repository.items[-1]
    actual = new_item_added
    assert_equal expected, actual
  end

  def test_it_can_update_attributes
    skip
    new_attributes = {
          :item_id => 7,
          :invoice_id => 8,
          :quantity => 1,
          :unit_price => BigDecimal.new(10.99, 4),
          :created_at => Time.now,
          :updated_at => Time.now
        }
    updated_attributes = {
      quantity: 13
    }
    @invoice_item_repository.create(new_attributes)
    new_invoice_item = @invoice_invoice_item_repository.invoice_items.last

    last_invoice_item_name = new_invoice_item.name
    last_invoice_item_description = new_invoice_item.description
    last_invoice_item_price = new_invoice_item.unit_price

    assert_equal "pots", last_invoice_item_name
    assert_equal "shiny", last_invoice_item_description
    assert_equal 10.99, last_invoice_item_price

    @invoice_invoice_item_repository.update(updated_attributes)
    changed_invoice_item = @invoice_invoice_item_repository.invoice_items.last

    assert_equal "chicken", changed_invoice_item.name
    assert_equal "fat", changed_invoice_item.description
    assert_equal 12.0, changed_invoice_item.unit_price

    assert_equal new_invoice_item.id, changed_invoice_item.id
  end

  def test_it_can_delete_invoice_item
    assert_equal @invoice_item_repository.invoice_items[0], @invoice_item_repository.find_by_id(1)

    @invoice_item_repository.delete(1)
    assert_nil @invoice_item_repository.find_by_id(1)
  end
end
