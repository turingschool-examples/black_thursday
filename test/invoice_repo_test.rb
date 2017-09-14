require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_repo'
require 'pry'
require './lib/sales_engine'

class InvoiceRepoTest < Minitest::Test
  attr_reader :ir

  def setup
    @ir = InvoiceRepo.new("./data/invoices.csv")
  end

  def test_it_exists
    assert_instance_of InvoiceRepo, ir
  end

  def test_find_all_invoices
    assert_equal 4985, ir.all_invoices.count
  end

  def test_find_by_id
    assert_instance_of Invoice, ir.find_by_id(8)
    assert_equal 8, ir.find_by_id(8).id
    assert_nil ir.find_by_id(45423)
  end


  def test_find_all_by_customer_id
    assert_equal 8, ir.find_all_by_customer_id(1).count
    assert_empty ir.find_all_by_customer_id(12345)
  end

  def test_find_all_by_merchant_id
    assert_equal 11, ir.find_all_by_merchant_id(12334269).count
    assert_empty ir.find_all_by_merchant_id(2332525)
  end

  def test_find_by_status
    assert_equal "pending", ir.find_all_by_status("pending").first.status
    assert_empty ir.find_all_by_status("not here")
    refute_equal "pending", ir.find_all_by_status("shipped").first.status
  end
end
