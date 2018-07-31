require "minitest/autorun"
require 'minitest/pride'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/invoice_item'
require 'csv'


class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    @se= SalesEngine.from_csv({
      :items     => "./data/dummy_items.csv",
      :merchants => "./data/dummy_merchants.csv",
      :invoices  => "./data/dummy_invoices.csv",
      :invoice_items => "./data/dummy_invoice_items.csv" })
      @iir = InvoiceItemRepository.new(@se.csv_hash[:invoice_items])
      @iir.create_invoice_items
    end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, @iir
  end

  def test_it_can_return_an_array_of_all_known_invoice_item_instances
    assert_equal 9, @iir.all.count
  end

  def test_it_can_find_an_invoice_item_by_a_valid_id
    item_invoice = @iir.find_by_id(5)
    assert_instance_of InvoiceItem, item_invoice
    assert_equal 5, item_invoice.id
  end

  def test_it_returns_nil_if_invoice_id_is_invalid
    invoice = @iir.find_by_id(25)
    assert_nil invoice
  end
  #
  def test_it_can_find_all_by_item_id
    assert_equal 3, @iir.find_all_by_item_id(263519844).count
  end
  #
  def test_it_can_find_all_invoice_items_by_invoice_id
    assert_equal 8, @iir.find_all_by_invoice_id(1).count
  end
  #
  # def test_it_can_create_new_id
  #   invoice_item = @iir.create_id
  #   assert_equal 4, invoice_item
  # end
  #
  # def test_it_can_create_new_invoice_item
  #   attributes = {  item_id: 27,
  #                   invoice_id: 2772,
  #                   quantity: 4,
  #                   unit_price: 2134,
  #                   created_at: '2018-07-28',
  #                   updated_at: '2018-07-28'
  #                 }
  #   invoice_item = @iir.create(attributes)
  #   assert_equal 4, invoice_item.id
  #   assert_equal 27, invoice_item.item_id
  #   assert_equal 2772, invoice_item.invoice_id
  #   assert_equal 4, invoice_item.quantity
  #   assert_equal BigDecimal, invoice_item.unit_price.class
  #   assert_instance_of Time, invoice_item.created_at
  #   assert_instance_of Time, invoice_item.updated_at
  # end
  #
  # def test_it_can_update_invoice_item
  #   attributes = {
  #     quantity: 4,
  #     unit_price: 15635
  #   }
  #   id = 1
  #   invoice_item = @iir.update(id, attributes)
  #   expected = @iir.find_by_id(id)
  #   assert_instance_of Time, invoice_item.updated_at # maybe refactor later
  #   assert_equal 1, expected.invoice_id
  #   assert_equal 4, expected.quantity
  #   assert_equal 15635, expected.unit_price
  # end
  #
  # def test_it_can_delete_invoice
  #   id = 2
  #
  #   invoice = @iir.delete(id)
  #   expected = @iir.find_by_id(2)
  #
  #   assert_nil expected
  # end
end
