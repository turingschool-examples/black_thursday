require_relative 'test_helper'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < MiniTest::Test
  attr_reader :invoice_repo

  def setup
    @invoice_repo = InvoiceRepository.new
  end

  def test_all_contains_all_invoice_objects
    invoice_repo.populate('./test/fixtures/invoices_fixture.csv')

    assert_instance_of Array, invoice_repo.all
    assert_instance_of Invoice, invoice_repo.all.first
    assert_equal 4, invoice_repo.all.count
  end

  def test_can_find_invoice_by_id
    invoice_repo.populate('./test/fixtures/invoices_fixture.csv')

    assert_instance_of Invoice, invoice_repo.find_by_id(2)
    assert_nil invoice_repo.find_by_id(100)
  end

  def test_can_find_invoice_by_merchant_id
    invoice_repo.populate('./test/fixtures/invoices_fixture.csv')

    assert_instance_of Array, invoice_repo.find_all_by_merchant_id(12334753)
    assert_equal 0, invoice_repo.find_all_by_merchant_id(12334753).count
    assert_equal [], invoice_repo.find_all_by_merchant_id(100)
  end

  def test_can_find_invoice_by_customer_id
    invoice_repo.populate('./test/fixtures/invoices_fixture.csv')

    assert_instance_of Array, invoice_repo.find_all_by_customer_id(1)
    assert_equal 4, invoice_repo.find_all_by_customer_id(1).count
    assert_equal [], invoice_repo.find_all_by_customer_id(100)
  end

  def test_can_find_invoice_by_status
    invoice_repo.populate('./test/fixtures/invoices_fixture.csv')

    assert_instance_of Array, invoice_repo.find_all_by_status("shipped")
    assert_equal 1, invoice_repo.find_all_by_status("shipped").count
    assert_equal [], invoice_repo.find_all_by_status("hello")
  end

end
