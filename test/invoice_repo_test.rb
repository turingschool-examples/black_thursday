require_relative 'test_helper'
require_relative '../lib/invoice_repo'

class InvoiceRepoTest < Minitest::Test
  def test_invoice_repo_class_exists
    assert_instance_of InvoiceRepo, InvoiceRepo.new('./data/invoices.csv')
  end

  def test_invoice_repo_can_populate_with_invoice_objects_and_attributes
    invoice_repo = InvoiceRepo.new('./data/invoices.csv')
    assert_equal Invoice, invoice_repo.all.first.class
    assert_equal 1, invoice_repo.all.first.id
    assert_equal 1, invoice_repo.all.first.customer_id
    assert_equal 12335938, invoice_repo.all.first.merchant_id
    assert_equal :pending, invoice_repo.all.first.status
    assert_instance_of Time, invoice_repo.all.first.created_at
    assert_instance_of Time, invoice_repo.all.first.updated_at
  end

  def test_invoice_repo_can_find_all_invoices
    invoice_repo = InvoiceRepo.new('./data/invoices.csv')
    assert_equal 4985, invoice_repo.all.count
  end


  def test_invoice_repo_can_find_by_invoice_id
    invoice = InvoiceRepo.new('./data/invoices.csv').find_by_id(3)
    assert_equal 3, invoice.id
  end

  def test_invoice_repo_returns_nil_if_invoice_id_does_not_exist
    invoice = InvoiceRepo.new('./data/invoices.csv').find_by_id(2132131)
    assert_equal nil, invoice
  end

  def test_invoice_repo_can_find_all_by_customer_id
    invoice_repo = InvoiceRepo.new('./data/invoices.csv').find_all_by_customer_id(3)
    assert_equal 3, invoice_repo.count
  end

  def test_invoice_repo_can_find_all_by_merchant_id
    invoice_repo = InvoiceRepo.new('./data/invoices.csv').find_all_by_merchant_id(12335938)
    assert_equal 16, invoice_repo.count
  end

  def test_invoice_repo_can_find_all_by_status
    invoice_repo = InvoiceRepo.new('./data/invoices.csv').find_all_by_status(:returned)
    assert_equal 673, invoice_repo.count
  end
end
