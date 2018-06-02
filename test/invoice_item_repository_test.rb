require_relative 'test_helper'
require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/invoice_item_repository'
require 'minitest/autorun'
require 'minitest/pride'
class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    @engine = SalesEngine.from_csv({
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      customers: './data/customers.csv',
      invoices: './data/invoices.csv',
      invoice_items: './data/invoice_items.csv',
      transactions: './data/transactions.csv'
    })
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, @engine.invoice_items
  end

  def test_all_returns_an_array_of_all_invoice_item_instances
    expected = @engine.invoice_items.all
    assert_equal 21830, expected.count
  end

  def test_find_by_id_find_an_invoice_item_by_id
    id = 10
    expected = @engine.invoice_items.find_by_id(id)
    assert_equal id, expected.id
    assert_equal 263523644, expected.item_id
    assert_equal 2, expected.invoice_id
  end

  def test_find_by_id_returns_nil_if_the_invoice_item_does_not_exits
    id = 200000
    expected = @engine.invoice_items.find_by_id(id)
    assert_nil expected
  end

  def test_find_all_by_item_finds_all_items_matching_given_item_id
    item_id = 263408101
    expected = @engine.invoice_items.find_all_by_item_id(item_id)
    assert_equal 11, expected.length
    assert_instance_of InvoiceItem, expected.first
  end

  def test_find_all_by_item_id_returns_an_empty_array_if_there_are_no_matches
    item_id = 10
    expected = @engine.invoice_items.find_all_by_item_id(item_id)
    assert_equal [], expected
  end

  def test_find_all_by_invoice_id_finds_all_items_matching_given_item_id
    invoice_id = 100
    expected = @engine.invoice_items.find_all_by_invoice_id(invoice_id)
    assert_equal 3, expected.length
    assert_instance_of InvoiceItem, expected.first
  end

  def test_find_all_by_invoice_id_returns_an_empty_array_if_it_finds_no_matches
    invoice_id = 1234567890
    expected = @engine.invoice_items.find_all_by_invoice_id(invoice_id)
    assert_equal [], expected
  end

  def test_create_creates_a_new_invoice_item_instance
    attributes = {
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal.new(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    }
    @engine.invoice_items.create(attributes)
    expected = @engine.invoice_items.find_by_id(21831)
    assert_equal 7, expected.item_id
    assert_equal 8, expected.invoice_id
    assert_equal 1, expected.quantity
  end

  def test_update_updates_an_invoice_item
    attributes = {
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal.new(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    }
    @engine.invoice_items.create(attributes)
    original_time = @engine.invoice_items.find_by_id(21831).updated_at
    attributes = {quantity: 13}
    @engine.invoice_items.update(21831, attributes)
    expected = @engine.invoice_items.find_by_id(21831)
    assert_equal 13, expected.quantity
    assert_equal 7, expected.item_id
    assert expected.updated_at > original_time
  end

  def test_update_cannot_update_id_item_id_invoice_id_or_create_at
    attributes = {
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal.new(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    }
    @engine.invoice_items.create(attributes)
    updated_attributes = {
      id: 22000,
      item_id: 32,
      invoice_id: 53,
      created_at: Time.now
    }
    @engine.invoice_items.update(21831, updated_attributes)
    expected = @engine.invoice_items.find_by_id(22000)
    assert_nil expected
    expected = @engine.invoice_items.find_by_id(21831)
    assert updated_attributes[:item_id] != expected.item_id
    assert updated_attributes[:invoice_id] != expected.invoice_id
    assert updated_attributes[:created_at] != expected.created_at
  end

  def test_update_on_unkown_invoice_item_does_nothing
    expected = @engine.invoice_items.update(22000, {})
    assert_nil expected
  end

  def test_delete_deletes_the_specified_invoice
    assert @engine.invoice_items.find_by_id(1)
    @engine.invoice_items.delete(1)
    refute @engine.invoice_items.find_by_id(1)
  end

  def test_delete_on_unknown_invoice_does_nothing
    expected = @engine.invoice_items.delete(22000)
    assert_nil expected
  end
end
