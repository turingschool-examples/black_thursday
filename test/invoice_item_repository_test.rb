require_relative '../lib/invoice_item_repository'
require_relative '../test/test_helper'


class InvoiceItemRepositoryTest < Minitest::Test

  attr_reader :ir

  def setup
    @ir = InvoiceItemRepository.new("./test/fixtures/invoice_items_sample.csv", "se")
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, ir
  end

  def test_invoice_items_is_filled
    assert ir.invoice_items.all? { |ii| ii.class == InvoiceItem }
    assert_equal 8, ir.invoice_items.count
  end

  def test_all_returns_all_invoice_items
    assert_equal 8, ir.all.count
    assert ir.all.all? { |ii| ii.class == InvoiceItem}
  end

  def test_it_returns_invoice_item_by_id
    invoice_item = ir.find_by_id(4)

    assert_instance_of InvoiceItem, invoice_item
    refute_instance_of InvoiceItemRepository, invoice_item
    assert_equal 4, invoice_item.id
    refute_equal 2, invoice_item.id
  end

  def test_it_returns_all_items_by_id
    invoice_items = ir.find_all_by_item_id(263454779)

    assert invoice_items.all? { |ii| ii.class == InvoiceItem }
    assert invoice_items.all? { |ii| ii.item_id == 263454779 }
    refute invoice_items.any? { |ii| ii.item_id == 263454234 }
  end

  def test_it_returns_all_invoice_items_by_invoice_id
    invoice_items = ir.find_all_by_invoice_id(1)

    assert invoice_items.all? { |ii| ii.class == InvoiceItem }
    assert invoice_items.all? { |ii| ii.invoice_id == 1 }
  end

end
