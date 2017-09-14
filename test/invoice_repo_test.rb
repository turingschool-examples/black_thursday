require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_repo'
require 'pry'

class InvoiceRepoTest < MiniTest::Test

  def test_it_exist
    ir = InvoiceRepo.new("./data/invoices.csv")

    assert_instance_of InvoiceRepo, ir
  end

  def test_all_instances_of_invoice_initialize_with_count
    ir = InvoiceRepo.new("./data/invoices.csv")

    assert_equal 4985, ir.all.count
  end

  def test_find_by_id_returns_matching_id
    ir = InvoiceRepo.new("./data/invoices.csv")

    assert_equal 1, ir.find_by_id(1).customer_id
  end

  def test_find_all_by_customer_id
    ir = InvoiceRepo.new("./data/invoices.csv")

    assert_equal 5, ir.find_all_by_customer_id(14).count
  end

  def test_find_all_by_merchant_id
    ir = InvoiceRepo.new("./data/invoices.csv")

    assert_equal 11, ir.find_all_by_merchant_id(12334395).count
  end

  def test_find_all_by_status
    ir = InvoiceRepo.new("./data/invoices.csv")

    assert_equal 1473, ir.find_all_by_status(:pending).count
  end

end
