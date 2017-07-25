require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_item_repo'

class InvoiceItemRepositoryTest < Minitest::Test

  def test_it_exist
    invoice_item_repo = InvoiceItemRepository.new("csv_data")

    assert_instance_of InvoiceItemRepository, invoice_item_repo
  end

  def test_can_return_array_all_known_invoice_item_instances
    invoice_item_repo = InvoiceItemRepository.new("csv_data")

    assert_equal [], invoice_item_repo.
  end

  def test_can_find_by_id
    invoice_item_repo = InvoiceItemRepository.new("csv_data")


  end

  def test_can_find_all_by_item_id
    invoice_item_repo = InvoiceItemRepository.new("csv_data")

  end

  def test_can_find_all_by_item_id
    invoice_item_repo = InvoiceItemRepository.new("csv_data")


  end

  def test_can_find_all_invoice_id
    invoice_item_repo = InvoiceItemRepository.new("csv_data")


  end

end
