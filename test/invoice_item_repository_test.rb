# frozen_string_literal: false

require_relative 'test_helper'
require './lib/sales_engine'
require './lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv(invoice_items: './data/invoice_items.csv')
    @iir = @se.invoice_items
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, @iir
  end

  def test_invoice_item_repo_holds_all_instances_of_invoice_items
    assert_equal 21_830, @iir.all.length
  end

  def test_all_returns_array_of_all_invoice_item_objects
    assert @iir.all.all? do |invoice_item|
      invoice_item.class == InvoiceItem
    end
  end

  def test_find_by_id_returns_invoice_item_with_given_id
    refute @iir.find_by_id('notarealid')
    assert_instance_of InvoiceItem, @iir.find_by_id(30)
    assert_equal 30, @iir.find_by_id(30).id
    assert_equal 263_543_430, @iir.find_by_id(30).item_id
    assert_equal 6, @iir.find_by_id(30).invoice_id
    assert_equal 6, @iir.find_by_id(30).quantity
    assert_equal 182.22, @iir.find_by_id(30).unit_price
  end

  def test_find_all_by_invoice_item_id
    assert_equal [], @iir.find_all_by_item_id('notarealid')
    assert_instance_of Array, @iir.find_all_by_item_id(263_522_956)
    assert_equal 19, @iir.find_all_by_item_id(263_522_956).length
  end

  def test_find_all_by_invoice_id
    assert_equal [], @iir.find_all_by_invoice_id('notarealid')
    assert_instance_of Array, @iir.find_all_by_invoice_id(6)
    assert_equal 7, @iir.find_all_by_invoice_id(6).length
  end

  def test_it_can_create_a_new_invoice_item_object
    refute @iir.find_by_id(21_831)
    attributes = { item_id: 7,
                   invoice_id: 8,
                   quantity: 1,
                   unit_price: BigDecimal(10.99, 4),
                   created_at: Time.now,
                   updated_at: Time.now }
    @iir.create(attributes)
    assert_equal 21_831, @iir.find_by_id(21_831).id
  end

  def test_it_can_update_a_invoice_item
    @iir.create(item_id: 7,
                invoice_id: 8,
                quantity: 6,
                unit_price: BigDecimal(10.99, 4),
                created_at: Time.now,
                updated_at: Time.now)
    assert @iir.find_by_id(21_831)
    assert_equal 6, @iir.find_by_id(21_831).quantity

    @iir.update(21_831, quantity: 4, unit_price: BigDecimal(10.99, 4))
    assert_equal 4, @iir.find_by_id(21_831).quantity
  end

  def test_it_can_delete_an_invoice_item_object
    assert @iir.find_by_id(6)
    @iir.delete(6)
    refute @iir.find_by_id(6)
  end
end
