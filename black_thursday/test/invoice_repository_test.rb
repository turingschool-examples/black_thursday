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

  def test_can_find_all_items_by_merchant_id
    actual = repository.find_all_by_merchant_id(12334105)

    assert_equal Array, actual.class
    assert_equal 0, actual.count
    assert_equal "Shopin1901", actual.name
  end
end
