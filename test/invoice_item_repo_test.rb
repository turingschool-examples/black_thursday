require './test/test_helper'
require './lib/invoice_item_repo'

class InvoiceItemRepositoryTest < Minitest::Test

  def setup
    csvfile = CSV.open "./data/invoice_items.csv", headers: true, header_converters: :symbol
    @invoice_item_repo = InvoiceItemRepository.new(csvfile, "engine")
  end

  def test_it_exist
    assert_instance_of InvoiceItemRepository, @invoice_item_repo
  end

  def test_can_find_by_id
    invoice_item_id = 1
    invalid_invoice_item_id = 0

    assert_instance_of InvoiceItem, @invoice_item_repo.find_by_id(invoice_item_id)
    assert_nil @invoice_item_repo.find_by_id(invalid_invoice_item_id)
  end

  def test_can_find_all_by_item_id
    item_id = 263519844

    assert_instance_of Array, @invoice_item_repo.find_all_by_item_id(item_id)
  end

  def test_can_find_all_by_invoice_id
    invoice_id = 1

    assert_instance_of Array, @invoice_item_repo.find_all_by_invoice_id(invoice_id)
  end

end
