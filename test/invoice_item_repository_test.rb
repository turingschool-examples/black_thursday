require "./test/test_helper"
require "./lib/invoice_item_repository"

class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    @invoice_items = InvoiceItemRepository.new("./test/fixtures/invoice_items_fixtures.csv")
  end

  def test_all_returns_all_invoices
    assert_equal @invoice_items.invoice_items.values, @invoice_items.all
  end

  def test_find_by_id_returns_invoice_item
    assert_instance_of InvoiceItem, @invoice_items.find_by_id(3190)
  end

  def test_find_by_id_returns_nil_when_passed_nonmatching_id
    assert_nil @invoice_items.find_by_id(13)
  end

  def test_argument_raised_if_find_by_id_is_passed_non_integer
    assert_raises ArgumentError do
      @invoice_items.find_by_id('carl')
    end

    assert_raises ArgumentError do
      @invoice_items.find_by_id([403, 404])
    end
  end

  def test_find_all_by_item_id_returns_array_of_invoice_items
    assert_instance_of Array, @invoice_items.find_all_by_item_id(263437745)

    assert_equal 263437745, @invoice_items.find_all_by_item_id(263437745).first.item_id
  end

  def test_find_by_item_id_returns_empty_array_when_passed_nonmatching_id
    assert @invoice_items.find_all_by_item_id(13).empty?
  end

  def test_argument_raised_if_find_all_by_item_id_is_passed_non_integer
    assert_raises ArgumentError do
      @invoice_items.find_all_by_item_id('carl')
    end

    assert_raises ArgumentError do
      @invoice_items.find_all_by_item_id([403, 404])
    end
  end

  def test_find_all_by_invoice_id_returns_array_of_invoice_items
    assert_instance_of Array, @invoice_items.find_all_by_invoice_id(4580)

    assert_equal 4580, @invoice_items.find_all_by_invoice_id(4580).first.invoice_id
  end

  def test_find_by_invoice_id_returns_empty_array_when_passed_nonmatching_id
    assert @invoice_items.find_all_by_invoice_id(13).empty?
  end

  def test_argument_raised_if_find_all_by_invoice_id_is_passed_non_integer
    assert_raises ArgumentError do
      @invoice_items.find_all_by_invoice_id('carl')
    end

    assert_raises ArgumentError do
      @invoice_items.find_all_by_invoice_id([403, 404])
    end
  end

  def test_inspect_returns_string
    assert_equal "#<InvoiceItemRepository 16 rows>", @invoice_items.inspect
  end
end
