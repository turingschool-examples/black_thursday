require_relative 'test_helper.rb'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test
  attr_reader :ir

  def setup
    @ir = InvoiceRepository.new("./test/fixtures/invoices_test.csv")
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, ir
  end

  def test_it_creates_new_instances_of_item
    assert_instance_of Invoice, ir.all.first
    assert_equal 1, ir.all.first.id
  end

  def test_it_returns_all_instances_of_item
    assert_equal 29, ir.all.count
  end

  def test_it_can_find_by_id
    assert_instance_of Invoice, ir.find_by_id(1)
    assert_equal 10, ir.find_by_id(3).customer_id
  end

  def test_it_returns_nil_if_it_does_not_find_id_number
    assert_nil ir.find_by_id(26339523799933)
  end

  def test_it_can_find_all_by_customer_id
    assert_instance_of Invoice, ir.find_all_by_customer_id(1).first
    assert_equal 5, ir.find_all_by_customer_id(1).count
    assert_equal 1, ir.find_all_by_customer_id(1).first.id
  end

  def test_find_all_by_customer_id_returns_empty_array_if_no_matches
    assert_equal [], ir.find_all_by_customer_id("rrrrrrrr")
  end

  def test_it_finds_all_by_merchant_id
    assert_instance_of Invoice, ir.find_all_by_merchant_id(12334185).first
    assert_equal 10, ir.find_all_by_merchant_id(12334185).count
    assert_equal 778, ir.find_all_by_merchant_id(12334185).first.id
  end

  def test_it_returns_empty_array_when_merchant_id_not_found
    assert_equal [], ir.find_all_by_merchant_id("rrrrrrrr")
  end

  def test_it_finds_all_by_status
    assert_instance_of Invoice, ir.find_all_by_status("shipped").first
    assert_equal 10, ir.find_all_by_status("shipped").count
    assert_equal 787, ir.find_all_by_status("shipped").last.id
  end

  def test_find_all_in_price_range_returns_empty_array_if_no_matches
    assert_equal [], ir.find_all_by_status("jajaja")
  end

end