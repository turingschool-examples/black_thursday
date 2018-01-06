require "./test/test_helper"
require "./lib/invoice_item_repository"

class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    @invoice_items = InvoiceItemRepository.new("./test/fixtures/invoice_items_fixtures.csv")
  end

  def test_all_returns_all_invoices
    assert_equal @invoice_items.invoice_items.values, @invoice_items.all
  end

  def test_find_all_by_id_returns_invoice_item
    assert_instance_of InvoiceItem, @invoice_items.find_by_id(3190)
  end
end
