require_relative 'test_helper'
require_relative '../lib/invoice_repository.rb'
require 'pry'

class InvoiceRepositoryTest < Minitest::Test

  def test_new_instance
    ir = InvoiceRepository.new("./test/data/invoices_fixture.csv", self)

    assert_instance_of InvoiceRepository, ir
  end

  def test_return_all_instances
    skip #need to figure out how to gather verification data
    ir = InvoiceRepository.new("./test/data/invoices_fixture.csv", self)

    assert_equal x, x
  end

  def test_return_instance_with_find_by_id_good_id
    ir = InvoiceRepository.new("./test/data/invoices_fixture.csv", self)
    actual = ir.find_by_id(30).id

    assert_equal 30, actual
  end

  def test_return_nil_with_find_by_id_bad_number
    ir = InvoiceRepository.new("./test/data/invoices_fixture.csv", self)

    assert_nil ir.find_by_id(3)
  end

  def test_return_find_all_by_customer_id_good_id
    skip #need to figure out how to ananlyze the return
    ir = InvoiceRepository.new("./test/data/invoices_fixture.csv", self)
    actual = ir.find_all_by_customer_id(1)
    expected =

    assert_equal expected, actual
  end

  def test_return_find_all_by_customer_id_bad_id
    ir = InvoiceRepository.new("./test/data/invoices_fixture.csv", self)

    assert_equal [], ir.find_all_by_customer_id(10)
  end

  def test_find_all_by_merchant_id_good_id
    skip #need to figure out how to analyze the return
    ir = InvoiceRepository.new("./test/data/invoices_fixture.csv", self)

    assert_equal x, y
  end

  def test_find_all_by_merchant_id_bad_id
    ir = InvoiceRepository.new("./test/data/invoices_fixture.csv", self)

    assert_equal [], ir.find_all_by_merchant_id(34)
  end

  def test_find_all_by_status_good_status
    skip #need to figure out how to analyze the return
    ir = InvoiceRepository.new("./test/data/invoices_fixture.csv", self)

    assert_equal [], ir.find_all_by_status("pending")
  end

  def test_find_all_by_status_bad_status
    ir = InvoiceRepository.new("./test/data/invoices_fixture.csv", self)

    assert_equal [], ir.find_all_by_status("pend")
  end

end
