require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    @invoices = mock('invoicerepository')
    @invoice_items = InvoiceItemRepository.new(@invoices)
    file_path = './test/fixtures/invoice_items_truncated.csv'
    @invoice_items.from_csv(file_path)
  end

  def test_it_returns_all_known_invoice_items
    invoice_items = @invoice_items.all

    all_invoice_items = invoice_items.all? do |invoice_item|
      invoice_item.class == InvoiceItem
    end

    assert_equal 60, invoice_items.length
    assert all_invoice_items
  end

  def test_it_can_find_an_invoice_item_by_id
    invoice_item = @invoice_items.find_by_id(2778)

    assert_instance_of InvoiceItem, invoice_item
    assert_equal 2778, invoice_item.id
  end

  def test_find_by_id_returns_nil_if_no_invoice_with_id
    assert_nil @invoice_items.find_by_id(5)
  end

  def test_it_can_find_all_by_item_id
    invoice_items = @invoice_items.find_all_by_item_id(263395617)

    all_match_item_id = invoice_items.all? do |invoice_item|
      invoice_item.item_id == 263395617 && invoice_item.class == InvoiceItem
    end

    assert_equal 4, invoice_items.length
    assert all_match_item_id
  end

  def test_it_returns_an_empty_array_if_no_invoices_with_item_id
    invoice_items = @invoice_items.find_all_by_item_id(2633)

    assert invoice_items.empty?
  end

  def test_it_finds_all_invoice_items_by_invoice_id
    invoice_items = @invoice_items.find_all_by_invoice_id(4)

    all_match_invoice_id = invoice_items.all? do |invoice_item|
      invoice_item.invoice_id == 4 && invoice_item.class == InvoiceItem
    end

    assert_equal 1, invoice_items.length
    assert all_match_invoice_id
  end

  def test_it_finds_all_by_invoice_id_returns_an_empty_array_if_no_invoices_with_invoice_id
    invoice_items = @invoice_items.find_all_by_invoice_id(678)

    assert invoice_items.empty?
  end
end
