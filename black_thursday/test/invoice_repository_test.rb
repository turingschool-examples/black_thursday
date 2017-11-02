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
end
