# frozen_string_literal: true

require_relative 'test_helper'

require_relative '../lib/invoice_repository'
require_relative 'mocks/test_engine'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    @invoice_repo = InvoiceRepository.new './test/fixtures/invoices.csv',
                                          MOCK_SALES_ENGINE
  end

  def test_does_create_repository
    assert_instance_of InvoiceRepository, @invoice_repo
  end

  def test_loads_invoices
    assert_equal 18, @invoice_repo.all.count
    assert_instance_of Array, @invoice_repo.all
    check_invoice_array
    assert_equal 1, @invoice_repo.all.first.customer_id
    assert_equal 1, @invoice_repo.all.first.merchant_id
    assert_equal :pending, @invoice_repo.all.first.status
  end

  def check_invoice_array
    @invoice_repo.all.each do |invoice|
      assert_instance_of Invoice, invoice
    end
  end

  def test_can_find_invoices_by_id
    result = @invoice_repo.find_by_id 8

    assert_instance_of Invoice, result
    assert_equal 1, result.customer_id
    assert_equal 4, result.merchant_id
    assert_equal :shipped, result.status
  end

  def test_can_find__all_invoices_by_customer_id
    result = @invoice_repo.find_all_by_customer_id 2

    assert_instance_of Array, result
    assert_equal 8, result.length
    result.each do |invoice|
      assert_instance_of Invoice, invoice
      assert_equal 2, invoice.customer_id
    end
  end

  def test_can_find_all_invoices_by_merchant_id
    result = @invoice_repo.find_all_by_merchant_id 3

    result.each do |invoice|
      assert_instance_of Invoice, invoice
      assert_equal 3, invoice.merchant_id
    end
  end

  def test_it_can_find_all_invoices_by_status
    result = @invoice_repo.find_all_by_status :shipped

    assert_equal 6, result.length
    result.each do |invoice|
      assert_instance_of Invoice, invoice
      assert_equal :shipped, invoice.status
    end
  end

  def test_it_overrides_inspect
    assert_equal '#<InvoiceRepository 18 rows>', @invoice_repo.inspect
  end
end
