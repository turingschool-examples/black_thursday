require_relative '../test/test_helper'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test

  def test_it_exists
    parent = mock("parent")
    iir = InvoiceItemRepository.new("./test/fixtures/invoice_items_fixture.csv", parent)

    assert_instance_of InvoiceItemRepository, iir
  end

  def test_all_returns_array_of_invoice_items
    parent = mock("parent")
    iir = InvoiceItemRepository.new("./test/fixtures/invoice_items_fixture.csv", parent)

    iir.all.each {|invoice_item| assert_instance_of InvoiceItem, invoice_item}
    assert_equal 26, iir.all.count
    assert_equal 1, iir.all.first.id
    assert_equal 263395237, iir.all.first.item_id
    assert_equal 26, iir.all.last.id
    assert_equal 263396517, iir.all.last.item_id
  end

  def test_find_by_id_returns_proper_invoice_item_or_nil
    parent = mock("parent")
    iir = InvoiceItemRepository.new("./test/fixtures/invoice_items_fixture.csv", parent)

    invoice_item = iir.find_by_id(13)
    unknown = iir.find_by_id(21312)

    assert_equal 263396255, invoice_item.item_id
    assert_nil unknown
  end

  def test_find_all_by_item_id_returns_array_of_matching
    parent = mock("parent")
    iir = InvoiceItemRepository.new("./test/fixtures/invoice_items_fixture.csv", parent)

    invoice_items = iir.find_all_by_item_id(263396517)
    unknown = iir.find_all_by_item_id(21312)

    assert_equal [], unknown
    assert_equal 7, invoice_items.count
    assert_equal 233.24, invoice_items.first.unit_price
    assert_equal 734.08, invoice_items.last.unit_price
  end

  def test_find_all_by_invoice_id_returns_array_of_matching
    parent = mock("parent")
    iir = InvoiceItemRepository.new("./test/fixtures/invoice_items_fixture.csv", parent)

    invoice_items = iir.find_all_by_invoice_id(13)
    unknown = iir.find_all_by_invoice_id(21312)

    assert_equal [], unknown
    assert_equal 2, invoice_items.count
    assert_equal 263396517, invoice_items.first.item_id
    assert_equal 263396255, invoice_items.last.item_id
  end

end
