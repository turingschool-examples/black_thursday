require 'time'
require_relative 'test_helper'
require './lib/invoice_item_repository'
require './lib/sales_engine'
require 'pry'

# This is an ItemRepository Class
class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv(
      {
        items:         './test/fixtures/items_truncated.csv',
        merchants:     './test/fixtures/merchants_truncated.csv',
        invoices:      './test/fixtures/invoices_truncated.csv',
        invoice_items: './test/fixtures/invoice_items_truncated.csv',
        transactions:   './test/fixtures/transactions_truncated.csv',
        customers:     './test/fixtures/customers_truncated.csv'
      } )

    @ir = @se.invoice_items
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, @ir
  end

  def test_it_has_items
    assert_equal 10, @ir.all.count
    assert_instance_of Array, @ir.all
  end

  def test_find_by_id
    assert_instance_of InvoiceItem, @ir.find_by_id(1)
  end

  def test_find_invoice_items_by_id
    assert_nil @ir.find_by_id(777)
    assert_instance_of InvoiceItem, @ir.find_by_id(1)
  end

  def test_find_all_by_item_id
    actual = @ir.find_all_by_item_id(1)

    assert_instance_of Array, actual
    assert_equal 4, actual.count
  end

  def test_find_all_by_invoice_id
    actual = @ir.find_all_by_invoice_id(1)

    assert_instance_of Array, actual
    assert_equal 8, actual.count
  end

  def test_create_invoice_item
    assert_equal 10, @ir.invoice_items.last.id

    @ir.create({
                :item_id => 11,
                :invoice_id => 12,
                :quantity => 13,
                :unit_price => 10
              })

    actual = @ir.invoice_items.last

    assert_equal 11, actual.id
    assert_equal 11, actual.item_id
    assert_equal 13, actual.quantity
    assert_equal 0.1, actual.unit_price
  end

  def test_update_item
    attributes = ({
                    :quantity => 7,
                    :unit_price => 15
                   })

    to_update = @ir.find_by_id(10)

    assert_equal 4, to_update.quantity
    assert_equal 18.59, to_update.unit_price

    @ir.update(10, attributes)

    assert_equal 7, to_update.quantity
    assert_equal 15, to_update.unit_price
  end

  def test_delete_item
    actual = @ir.invoice_items

    assert_equal 10, actual.count

    @ir.delete(1)

    assert_nil @ir.find_by_id(1)
    assert_equal 9, actual.count
  end
end
