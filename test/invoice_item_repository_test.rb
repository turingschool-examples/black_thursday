require './test/test_helper'
require './lib/invoice_item_repository'
require './lib/sales_engine'
require './lib/searching'

class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    file_name = './data/sample_data/invoice_items.csv'
    @invoice_item_repo = InvoiceItemRepository.new(file_name)
  end

  def test_it_exists
      assert_instance_of InvoiceItemRepository, @invoice_item_repo
  end

  def test_it_finds_by_item_id
    assert_instance_of Array, @invoice_item_repo.all
    assert_nil @invoice_item_repo.find_all_by_item_id(10)
    # assert_instance_of Invoice, @invoice_repo.find_by_id(4)
  end
end
