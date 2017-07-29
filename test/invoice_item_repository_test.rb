require_relative 'test_helper'
require './lib/invoice_item_repository'
require 'csv'

class InvoiceItemRepositoryTest < Minitest::Test
  def test_it_exists
    ir = InvoiceItemRepository.new("./data/mini_invoice_items.csv")
    assert_instance_of InvoiceItemRepository, ir
  end

  def test_it_can_load_repository
    ir = InvoiceItemRepository.new("./data/mini_invoice_items.csv")
    assert_equal 2, ir.repository.count
  end

  def test_it_can_return_all_known_invoice_items
    ir = InvoiceItemRepository.new("./data/mini_invoice_items.csv")
    assert_equal 2, ir.all.count
  end

  def test_it_can_find_by_id
    ir = InvoiceItemRepository.new("./data/mini_invoice_items.csv")
    assert_instance_of InvoiceItem, ir.find_by_id(1)
  end

  def test_it_can_find_invoice_items_by_matching_item_id
    ir = InvoiceItemRepository.new("./data/mini_invoice_items.csv")
    assert_instance_of Array, ir.find_all_by_item_id(263454779)
  end

end
