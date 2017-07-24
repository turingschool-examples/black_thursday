require_relative 'test_helper'
require_relative '../lib/invoice_repo'

class InvoiceRepoTest < Minitest::Test
  attr_reader :ir

  def setup
    @ir = InvoiceRepo.new("./data/invoice_fixtures.csv")
  end

  def test_it_exists
    assert_instance_of InvoiceRepo, ir
  end

  def test_it_can_find_all_invoices
    assert_equal 100, ir.all.count
  end

  def test_all_is_array_of_invoices
    assert_instance_of Invoice, ir.all[0]
  end

  def test_it_can_find_by_id
    assert_instance_of Invoice, ir.find_by_id(5)
  end

  def test_returns_nil_if_no_id_present
    assert_nil ir.find_by_id(85769)
  end

  def test_it_can_find_all_customers
    assert_equal 8, ir.find_all_by_customer_id(5).count
  end

  def test_returns_empty_array_if_no_valid_cust_id
    assert_equal [], ir.find_all_by_customer_id(6930457)
  end

  def test_it_can_find_all_by_merchant_id
    assert_equal 2, ir.find_all_by_merchant_id(12335955).count
  end

  def test_returns_empty_array_if_no_valid_merch_id
    assert_equal [], ir.find_all_by_merchant_id(000000000000000)
  end

  def test_it_can_find_all_by_status_pending
    assert_equal 29, ir.find_all_by_status("pending").count
  end
end
