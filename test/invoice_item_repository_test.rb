require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test
  def test_it_exists
    inv_item = InvoiceItemRepository.new("./data/invoice_items.csv")

    assert_instance_of InvoiceItemRepository, inv_item
  end

  def test_repo_pulls_in_CSV_info_from_invitems
    inv_items = InvoiceItemRepository.new("./data/invoice_items.csv")

    assert_equal 21830, inv_items.all.count
  end

  def test_it_returns_array_of_all_invoice_items
    inv_items = InvoiceItemRepository.new("./data/invoice_items.csv")

    assert_equal 21830, inv_items.all.count
  end

  def test_it_can_find_by_id
    inv_items = InvoiceItemRepository.new("./data/invoice_items.csv")

    assert_instance_of InvoiceItem, inv_items.find_by_id(1)
    assert_equal 5, inv_items.find_by_id(5).id
  end

  def test_it_can_find_all_by_item_id
    inv_items = InvoiceItemRepository.new("./data/invoice_items.csv")
    instances = inv_items.find_all_by_item_id(263451719)

    assert_equal 263451719, instances[3].item_id
    assert_equal 13, instances.count
  end

  def test_it_can_find_all_by_invoice_id
    inv_items = InvoiceItemRepository.new("./data/invoice_items.csv")
    instances = inv_items.find_all_by_invoice_id(12)

    assert_equal 12, instances[3].invoice_id
    assert_equal 6, instances.count
  end
end
