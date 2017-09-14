require_relative 'test_helper.rb'
require_relative '../lib/invoice_repository.rb'
require 'csv'

class InvoiceRepositoryTest < Minitest::Test
  attr_accessor :repo

  def setup
    @repo = InvoiceRepository.new('data/invoices.csv')
  end

  def test_exists
    assert repo
    assert_instance_of InvoiceRepository, repo
  end

  def test_returns_array_all_invoice_instances
    assert_equal 4985, repo.all.length
  end

  def test_find_by_id
    invoice_id = 3452
    invoice = repo.find_by_id(3452)

    assert_equal invoice.id, invoice_id
  end

  def test_find_all_by_customer_id
    invoices = repo.find_all_by_customer_id(300)

    assert_equal 10, invoices.length
  end

  def test_find_all_by_customer_id_can_return_no_match
    invoices = repo.find_all_by_customer_id(1738)

    assert_equal [], invoices
  end

  def test_find_all_by_merchant_id
    invoices = repo.find_all_by_merchant_id(12335080)

    assert_equal 7, invoices.length
  end

  def test_find_all_by_merchant_id_returns_empty_no_match
    invoices = repo.find_all_by_merchant_id(1000)

    assert_equal [], invoices
  end

  def test_find_all_by_status_shipped
    invoices = repo.find_all_by_status(:shipped)

    assert_equal 2839, invoices.length
  end

  def test_find_all_by_status_pending
    invoices = repo.find_all_by_status(:pending)

    assert_equal 1473, invoices.length
  end

  def test_find_all_by_status_sold
    invoices = repo.find_all_by_status(:sold)

    assert_equal [], invoices
  end
end
