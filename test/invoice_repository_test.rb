gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'

class InvoiceRepositoryTest < Minitest::Test

  def test_invoice_repo_exists
    ir = InvoiceRepository.new('./data/invoices.csv', self)

    assert_instance_of InvoiceRepository, ir
  end

  def test_invoice_repo_has_sales_engine_access
    se = SalesEngine.from_csv({
          :items     => "./data/items.csv",
          :merchants => "./data/merchants.csv",
          :invoices => "./data/invoices.csv"
        })
    ir = se.invoices

    assert_instance_of SalesEngine, ir.sales_engine
  end

  def test_invoice_repo_has_file_path
    ir = InvoiceRepository.new('./data/invoices.csv', self)

    assert_equal './data/invoices.csv', ir.file_path
  end

  def test_invoice_repo_can_load_id_repo
    ir = InvoiceRepository.new('./data/invoices.csv', self)

    assert_instance_of Hash, ir.id_repo
    refute ir.id_repo.empty?
    assert_equal 4985, ir.id_repo.count
  end

  def test_invoice_repo_can_search_all_invoices
    ir = InvoiceRepository.new('./data/invoices.csv', self)

    assert_instance_of Array, ir.all
    refute ir.all.empty?
    assert_equal 4985, ir.all.count
  end

end
