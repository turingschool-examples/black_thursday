require_relative 'test_helper'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test
  attr_reader :invoice_repo
   def setup
    parent        = Minitest::Mock.new
    @invoice_repo = InvoiceRepository.new('./data/test_invoices.csv', parent)
  end

  def test_it_exists
    assert InvoiceRepository.new
  end

  def test_it_initializes_with_a_file
    assert InvoiceRepository.new('./data/test_invoices.csv')
  end

  def test_it_has_custom_inspect
    assert_equal "#<InvoiceRepository: 74 rows>", invoice_repo.inspect
  end

  def test_find_all_by_merchant_id_calls_parent
    invoice_repo.parent.expect(:find_invoice_for_id, nil, [5])
    invoice_repo.find_invoice_for_id(5)
    invoice_repo.parent.verify
  end

  def test_it_turns_file_contents_to_CSV_object
    assert_equal CSV, invoice_repo.file_contents.class
  end

  def test_it_generates_array_of_item_objects_from_csv_object
    assert invoice_repo.all.all?{|row| row.class == Invoice}
  end

  def test_it_calls_id_of_item_object
    assert_equal 1, invoice_repo.all[0].id
  end

  def test_it_retrieves_all_item_objects
    assert_equal Invoice, invoice_repo.all[0].class
    assert_equal 74, invoice_repo.all.count
  end

  def test_item_ids_are_uniq
    ids = invoice_repo.all {|row| row[:id]}
    assert_equal ids, ids.uniq
  end

  def test_find_invoice_by_id_returns_an_instance_of_invoice
    id       = 1
    invoices = invoice_repo.find_by_id(id)
    assert_equal Invoice, invoices.class
  end

  def test_it_returns_nil_if_id_not_found
    id       = 123
    invoices = invoice_repo.find_by_id(id)
    assert_equal nil,invoices
  end

  def test_it_finds_all_items_by_customer_id
    customer_id = 1
    invoices    = invoice_repo.find_all_by_customer_id(customer_id)
    assert_equal 8, invoices.count
  end

  def est_it_returns_nil_if_customer_id_is_not_found
    customer_id = 10000000
    invoices    = invoice_repo.find_all_by_customer_id(merchant_id)
    assert_equal [], invoices.map{|item| item.merchant_id}
  end

  def test_it_finds_all_by_merchant_id
    merchant_id = 12335955
    invoices    = invoice_repo.find_all_by_merchant_id(merchant_id)
    assert_equal 2, invoices.count
  end

  def test_it_returns_nil_if_merchant_id_is_not_found
    merchant_id = 10000000
    invoices    = invoice_repo.find_all_by_merchant_id(merchant_id)
    assert_equal [], invoices.map{|item| item.merchant_id}
  end

  def test_it_finds_all_of_a_status
    status   = "pending"
    invoices = invoice_repo.find_all_by_status(status)
    assert_equal 21, invoices.count
  end

end
