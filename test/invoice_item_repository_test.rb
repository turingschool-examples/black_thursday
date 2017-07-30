require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'
require_relative '../lib/sales_engine'

class InvoiceItemRepositoryTest < Minitest::Test

  def test_invoice_item_repository_exists
    iir = InvoiceItemRepository.new("./data/invoice_items.csv", self)

    assert_instance_of InvoiceItemRepository, iir
  end

  def test_invoice_item_repo_has_sales_engine_access
    se = SalesEngine.from_csv({
      :invoice_items => './data/invoice_items.csv'
      })
    iir = se.invoice_items

    assert_instance_of SalesEngine, iir.sales_engine
  end

  def test_invoice_item_repo_has_file_path
    iir = InvoiceItemRepository.new("./data/invoice_items.csv", self)

    assert_equal './data/invoice_items.csv', iir.file_path
  end

  def test_invoice_item_repo_can_load_id_repo
    iir = InvoiceItemRepository.new("./data/invoice_items.csv", self)

    assert_instance_of Hash, iir.id_repo
    refute iir.id_repo.empty?
    assert_equal 21830, iir.id_repo.count
  end

  def test_invoice_item_repo_can_get_all_invoice_items
    iir = InvoiceItemRepository.new("./data/invoice_items.csv", self)
    invoice_items = iir.all

    assert_instance_of Array, invoice_items
    refute invoice_items.empty?
    assert_instance_of InvoiceItem, invoice_items[0]
    assert_equal 21830, invoice_items.count
  end

  def test_invoice_item_repo_can_find_by_id
    iir = InvoiceItemRepository.new("./data/invoice_items.csv", self)
    invoice_item = iir.find_by_id(7759)

    assert_instance_of InvoiceItem, invoice_item
    assert_equal 8, invoice_item.quantity
    assert_equal 1750, invoice_item.invoice_id
  end

  def test_invoice_item_repo_find_by_id_returns_empty_array_on_bad_search
    iir = InvoiceItemRepository.new("./data/invoice_items.csv", self)
    invoice_item = iir.find_by_id(9999999)

    assert_nil invoice_item
  end

  def test_invoice_item_repo_can_find_all_by_item_id
    iir = InvoiceItemRepository.new("./data/invoice_items.csv", self)
    invoice_items = iir.find_all_by_item_id(263431273)

    assert_instance_of Array, invoice_items
    assert_equal 17, invoice_items.count
  end

  def test_invoice_item_repo_find_all_by_item_id_returns_empty_array_on_bad_search
    iir = InvoiceItemRepository.new("./data/invoice_items.csv", self)
    invoice_items = iir.find_all_by_item_id(9999999999999)

    assert_instance_of Array, invoice_items
    assert_equal [], invoice_items
  end

  def test_invoice_item_repo_can_find_all_by_invoice_id
    iir = InvoiceItemRepository.new("./data/invoice_items.csv", self)
    invoice_items = iir.find_all_by_invoice_id(82)

    assert_instance_of Array, invoice_items
    assert_equal 6, invoice_items.count
  end

  def test_invoice_item_repo_find_all_by_invoice_id_returns_empty_array_on_bad_search
    iir = InvoiceItemRepository.new("./data/invoice_items.csv", self)
    invoice_items = iir.find_all_by_invoice_id(99999999)

    assert_instance_of Array, invoice_items
    assert_equal [], invoice_items
  end

end
