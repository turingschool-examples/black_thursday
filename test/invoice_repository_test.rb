require_relative 'test_helper'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'
require 'bigdecimal'
require 'pry'

# test for invoice repository class
class InvoiceRepositoryTest < Minitest::Test
  def setup
    @repo = InvoiceRepository.new('./test/fixtures/invoices.csv',
                                  'parent')
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @repo
  end

  def test_it_has_invoices
    assert_instance_of Array, @repo.all
    assert_equal 9, @repo.all.length
    assert_instance_of Invoice, @repo.all[0]
  end

  def test_load_invoices
    assert_nil @repo.load_invoices('./test/fixtures/invoices.csv')
  end

  def test_it_can_find_invoice_by_id
    result = @repo.find_by_id(12_345)
    assert_nil result

    result = @repo.find_by_id(1)

    assert_instance_of Invoice, result
    assert_equal :pending, result.status
    assert_equal 1, result.id
  end

  def test_it_can_find_all_by_customer_id
    result = @repo.find_all_by_customer_id(12_345)
    assert_equal [], result

    result = @repo.find_all_by_customer_id(1)

    assert_instance_of Array, result
    assert_instance_of Invoice, result[0]
  end

  def test_it_can_find_all_by_merchant_id
    result = @repo.find_all_by_merchant_id(12_345)
    assert_equal [], result

    result = @repo.find_all_by_merchant_id(3)

    assert_instance_of Array, result
    assert_instance_of Invoice, result[0]
  end

  def test_it_can_find_all_by_status
    result = @repo.find_all_by_status(:pending)

    assert_instance_of Array, result
    assert_instance_of Invoice, result[0]
    assert_equal 5, result.length
  end
end
