require_relative './test_helper'
require 'time'

class InvoiceItemRepositoryTest < Minitest::Test

  def setup
    item_path          = "./data/items.csv"
    merchant_path      = "./data/merchants.csv"
    invoice_path       = "./data/invoices.csv"
    invoice_item_path  = "./data/invoice_items.csv"
    arguments = {
                  :items     => item_path,
                  :merchants => merchant_path,
                  :invoices  => invoice_path,
                  :invoice_items => invoice_item_path
                }
    @engine = SalesEngine.from_csv(arguments)
    @invoice_item = @engine.invoice_items
  end



  def test_all_returns_an_array_of_all_invoice_item_instances
      expected = @invoice_item.all
      assert_equal 21830, expected.length
  end

  def test_find_by_id_finds_an_invoice_item_by_id
    id =10
    expected = @invoice_item.find_by_id(id)
    assert_equal id, expected.id
    assert_equal 263523644, expected.item_id
    assert_equal 2, expected.invoice_id
  end

  def test_find_by_id_returns_nil_if_the_invoice_item_does_not_exist
    id = 200000
    expected = @invoice_item.find_by_id(id)
    assert_nil expected
  end

  def test_find_all_by_item_id_finds_all_items_matching_given_item_id
    item_id = 263408101
    expected = @invoice_item.find_all_by_item_id(item_id)
    assert_equal 11, expected.length
    assert_equal InvoiceItem, expected.first.class
  end

  def test_find_all_by_item_id_returns_an_empty_array_if_there_are_no_matches
    item_id = 10
    expected = @invoice_item.find_all_by_item_id(item_id)
    assert_equal 0, expected.length
    assert_equal true, expected.empty?
  end

  def test_find_all_by_invoice_id_finds_all_items_matching_given_item_id
    invoice_id = 100
    expected = @invoice_item.find_all_by_invoice_id(invoice_id)
    assert_equal 3, expected.length
    assert_equal InvoiceItem, expected.first.class
  end

  def test_find_all_by_invoice_id_returns_an_empty_array_if_there_are_no_matches
    invoice_id = 1234567890
    expected = @invoice_item.find_all_by_invoice_id(invoice_id)
    assert_equal 0, expected.length
    assert_equal true, expected.empty?
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
      expected = @invoice_item.find_by_id(21831)
      assert_equal 7, expected.item_id
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
      original_time = @invoice_item.find_by_id(21831).updated_at

      attributes = {quantity: 13}
      @invoice_item.update(21831, attributes)
      expected = @invoice_item.find_by_id(21831)
      assert_equal 13,  expected.quantity
      assert_equal 7,   expected.item_id
      assert_operator original_time ,:<, expected.updated_at
  end

  def test_update_cannot_update_id_item_id_invoice_id_or_created_at
    attributes = {
        :item_id => 7,
        :invoice_id => 8,
        :quantity => 1,
        :unit_price => BigDecimal.new(10.99, 4),
        :created_at => Time.now,
        :updated_at => Time.now
        }
    @engine.invoice_items.create(attributes)

    attributes_1 = {
         id: 22000,
         item_id: 32,
         invoice_id: 53,
         created_at: Time.now
          }
    @engine.invoice_items.update(21831, attributes)

    expected_1 = @invoice_item.find_by_id(22000)
    assert_nil  expected_1

    expected_2 = @invoice_item.find_by_id(21831)
    assert_equal attributes[:item_id], expected_2.item_id
    assert_equal attributes[:invoice_id],expected_2.invoice_id
    assert       expected_2.created_at
  end

  def test_update_on_unkown_invoice_item_does_nothing
    @invoice_item.update(22000, {})
  end

  def test_delete_deletes_the_specified_invoice
    @invoice_item.delete(21831)
    expected = @invoice_item.find_by_id(21831)
    assert_nil expected
  end

  def test_delete_on_unknown_invoice_does_nothing
    @invoice_item.delete(22000)
  end
end
