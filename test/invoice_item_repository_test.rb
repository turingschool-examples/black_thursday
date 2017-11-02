require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'

class InvoiceItemRepositoryTest < Minitest::Test
  def test_it_exists
    inv_item = InvoiceItemRepository.new("./data/invoice_items.csv")

    assert_instance_of InvoiceItemRepository, inv_item
  end

  def test_repo_pulls_in_CSV_info_from_items
    inv_items = ItemRepository.new("./data/items.csv")

    assert_equal 1367, inv_items.all.count
  end

end
