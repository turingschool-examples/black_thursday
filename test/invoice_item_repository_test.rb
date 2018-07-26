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
  #
  # def test_it_can_create_new_id
  #   expected = "263567475"
  #   actual = @invoice_item_repository.create_id
  #   assert_equal expected, actual
  # end
  #
  # def test_it_can_update_attributes
  #   @invoice_item_repository.create({
  #     name: "pots",
  #     description: "shiny",
  #     unit_price: "1099",
  #     merchant_id: "5555"
  #     })
  #   new_item = @invoice_item_repository.items.last
  #
  #   last_item_name = new_item.name
  #   last_item_description = new_item.description
  #   last_item_price = new_item.unit_price
  #
  #   assert_equal "pots", last_item_name
  #   assert_equal "shiny", last_item_description
  #   assert_equal 10.99, last_item_price
  #
  #   @invoice_item_repository.update(263567475, {
  #     name: "chicken",
  #     description: "fat",
  #     unit_price: 12.00
  #     })
  #   changed_item = @invoice_item_repository.items.last
  #
  #   assert_equal "chicken", changed_item.name
  #   assert_equal "fat", changed_item.description
  #   assert_equal 12.0, changed_item.unit_price
  #
  #   assert_equal new_item.id, changed_item.id
  # end
  #
  # def test_it_can_delete_item
  #   assert_equal @invoice_item_repository.items[0], @invoice_item_repository.find_by_name("510+ RealPush Icon Set")
  #
  #   @invoice_item_repository.delete(263395237)
  #   assert_nil @invoice_item_repository.find_by_name("510+ RealPush Icon Set")
  # end
end
