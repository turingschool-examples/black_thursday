require "./test/test_helper"
require "./lib/sales_engine"
require "./lib/invoice_item_repository"
require './lib/invoice_item'

class InvoiceItemRepositoryTest < Minitest::Test

  attr_reader :invoice_item_repository

  def setup
    item_csv = "./test/test_fixtures/invoice_items_short.csv"
    @invoice_item_repository = InvoiceItemRepository.new('fake_invoice_item', item_csv)
  end

  def test_invoice_item_repository_exists
    assert_instance_of InvoiceItemRepository, invoice_item_repository
  end

  def test_all_makes_array_of_all_invoice_items
    assert_instance_of Array, invoice_item_repository.all
    assert_instance_of InvoiceItem, invoice_item_repository.all[0]
  end

  def test_item_id_returns_nil_for_invalid_id
    assert_nil  invoice_item_repository.find_by_id(1234)
  end

  def test_item_id_returns_item_instance_for_id
    assert_instance_of InvoiceItem, invoice_item_repository.find_by_id(1)
  end

  def test_find_all_by_item_id_returns_array_of_all_with_item_id
    assert_instance_of Array, invoice_item_repository.find_all_by_item_id(263519844)
    assert_instance_of InvoiceItem, invoice_item_repository.find_all_by_item_id(263519844)[0]
  end

  def test_find_all_by_invoice_id_returns_array_of_all_with_invoice_id
    assert_instance_of Array, invoice_item_repository.find_all_by_invoice_id(1)
    assert_instance_of InvoiceItem, invoice_item_repository.find_all_by_invoice_id(1)[0]
  end

end
