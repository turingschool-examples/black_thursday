require_relative '../test/test_helper'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test

  def test_it_exists
    iir = InvoiceItemRepository.new

    assert_instance_of InvoiceItemRepository, iir
  end

  def test_from_csv_creates_all_which_returns_array_of_invoice_items
    iir = InvoiceItemRepository.new

    iir.from_csv("./test/fixtures/invoice_items_fixture.csv")

    iir.all.each do |invoice_item|
      assert_instance_of InvoiceItem, invoice_item
    end
    assert_equal 26, iir.all.count
    assert_equal 1, iir.all[0].id
    assert_equal 263395237, iir.all[0].item_id
  end

  def test_find_by_id_returns_proper_invoice_item_or_nil
    iir = InvoiceItemRepository.new

    iir.from_csv("./test/fixtures/invoice_items_fixture.csv")
    invoice_item = iir.find_by_id(13)

    assert_equal 263396255, invoice_item.item_id
  end

  def test_find_all_by_item_id_returns_array_of_matching
    iir = InvoiceItemRepository.new

    iir.from_csv("./test/fixtures/invoice_items_fixture.csv")
    invoice_items = iir.find_all_by_item_id(263396517)

    assert_equal 7, invoice_items.count
    assert_equal 9, invoice_items[2].invoice_id
    assert_equal 309.49, invoice_items[2].unit_price
  end

  def test_find_all_by_invoice_id_returns_array_of_matching
    iir = InvoiceItemRepository.new

    iir.from_csv("./test/fixtures/invoice_items_fixture.csv")
    invoice_items = iir.find_all_by_invoice_id(13)

    assert_equal 2, invoice_items.count
    assert_equal 263396517, invoice_items[0].item_id
    assert_equal 5, invoice_items[1].quantity
  end

end
