require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'
require_relative'../lib/sales_engine'

class InvoiceRepositoryTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/dummy_items.csv",
      :merchants => "./data/dummy_merchants.csv",
      :invoices => "./data/dummy_invoices.csv"
      })
    @invoice_repo = InvoiceRepository.new(@se.csv_hash[:invoices])
   @invoice_repo.create_invoices
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @invoice_repo
  end

  def test_all
    assert_equal 8, @invoice_repo.all.count
  end

  def test_it_can_find_by_id
    assert_equal Invoice, @invoice_repo.find_by_id(2).class
  end
end
