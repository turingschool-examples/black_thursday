require_relative 'test_helper'
require 'csv'
require_relative './../lib/invoice'
require_relative './../lib/invoice_repository'
require_relative './../lib/sales_engine'

class InvoiceRepositoryTest < Minitest::Test
  attr_reader :repository,
              :engine

  def setup
    @engine = SalesEngine.from_csv(
      items: './test/fixtures/truncated_items.csv',
      merchants: './test/fixtures/truncated_merchants.csv',
      invoices: './test/fixtures/truncated_invoices.csv'
    )

    @repository = InvoiceRepository.new("./test/fixtures/truncated_invoices.csv", engine)
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @repository
  end

  def test_it_can_return_all_invoices
    assert_equal repository.invoices, @repository.all
    assert_equal 101, repository.all.length
  end

  def test_it_can_find_invoice_by_id
    assert_equal Invoice, repository.find_by_id(10).class
    assert_equal "pending", repository.find_by_id(10).status
    assert_equal "12334839", repository.find_by_id(10).merchant_id
  end

  def test_find_by_id_edge_case
    assert_nil repository.find_by_id(9898989898989)
    assert_nil repository.find_by_id("smushy")
    assert_nil repository.find_by_id("898989898989")
    assert_nil repository.find_by_id(nil)
  end

  def test_can_find_all_invoices_by_merchant_id
    actual = repository.find_all_by_merchant_id("12334105")

    assert_equal Array, actual.class
    assert_equal 1, actual.count
    assert_equal "14", actual.first.customer_id
  end

  def test_find_all_by_merchant_id_returns_empty_array_when_no_match_is_found
    actual = repository.find_all_by_merchant_id("9898989898")

    assert_equal [], actual
    assert_equal [], repository.find_all_by_merchant_id(nil)
  end

  def test_can_find_all_invoices_by_customer_id
    actual = repository.find_all_by_customer_id("1")

    assert_equal Array, actual.class
    assert_equal 8, actual.count
    assert_equal "12337139", actual.last.merchant_id
  end

  def test_find_all_by_customer_id_returns_empty_array_when_no_match_is_found
    actual = repository.find_all_by_customer_id("98989")

    assert_equal [], actual
    assert_equal [], repository.find_all_by_customer_id(nil)
  end
end
