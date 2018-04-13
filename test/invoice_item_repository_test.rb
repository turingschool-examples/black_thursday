# frozen_string_literal: true

require 'simplecov'
SimpleCov.start
require './lib/invoice_item_repository.rb'
require './lib/sales_engine.rb'
require 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require 'pry'

# Tests the functionality of the invoice item repository
class InvoiceItemRepositorytest < Minitest::Test
  attr_reader :invoice_items

  def setup
    se = SalesEngine.from_csv({:invoice_items => './fixtures/invoice_items_test.csv'})
    @invoice_items = se.invoice_items
  end

  def test_invoice_item_repo_exists
    assert_instance_of InvoiceItemRepository, @invoice_items
  end

  def test_it_can_find_all
    assert_equal 3, @invoice_items.all.length
  end

  def test_it_returns_nil_for_invalid_id
    expected = @invoice_items.find_by_id(5)

    assert_nil expected
  end

  def test_it_returns_instance_of_invoice_item_by_id
    expected = @invoice_items.find_by_id(1)

    assert_equal 1, expected.id
    assert_equal 263519844, expected.item_id
  end

  def test_it_returns_nil_for_invalid_invoice_item_by_item_id
    expected = @invoice_items.find_all_by_item_id(22334455)

    assert_nil expected
  end

  def test_it_finds_invoice_item_by_item_id
    expected = @invoice_items.find_all_by_item_id(263519844)

    assert_equal 263519844, expected.first.item_id
  end

  def test_it_returns_nil_for_invalid_invoice_item_by_invoice_id
    expected = @invoice_items.find_all_by_invoice_id(8)

    assert_nil expected
  end

  def test_it_finds_invoice_item_by_invoice_id
    expected = @invoice_items.find_all_by_invoice_id(1)

    assert_equal 1, expected.first.invoice_id
  end

  def test_it_can_create_a_new_invoice_item_with_attributes
    @invoice_items.create({
      item_id: '2534536',
      invoice_id: '8',
      quantity: '5',
      unit_price: '199',
      created_at: '2012-03-27 12:54:09 UTC',
      updated_at: '2012-03-27 12:54:09 UTC' })
    expected = @invoice_items.find_all_by_invoice_id(8).first

    assert_equal 4, expected.id
    assert_equal 4, invoice_items.all.length
  end

  def test_it_can_update_id_and_attributes
    invoice_items.update(1, {quantity: 10})
    expected = @invoice_items.find_by_id(1).quantity

    assert_equal 10, expected
  end

  def test_it_can_delete_by_id
    invoice_items.delete(1)

    assert_nil invoice_items.find_by_id(1)
  end

  def test_it_can_group_by_number_of_items
    expected = [1, 5]
    actual = @invoice_items.group_by_number_of_items.first

    assert_equal expected, actual
  end
end
