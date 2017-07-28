require_relative 'test_helper'
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

  def test_invoice_repo_can_find_invoice_by_id
    ir = InvoiceRepository.new('./data/invoices.csv', self)
    invoice = ir.find_by_id(4400)

    assert_instance_of Invoice, invoice
    assert_equal "returned", invoice.status
    assert_equal 878, invoice.customer_id
  end

  def test_invoice_repo_find_by_id_returns_nil_on_bad_search
    ir = InvoiceRepository.new('./data/invoices.csv', self)
    invoice = ir.find_by_id(99999999)

    assert_nil invoice
  end

  def test_invoice_repo_can_find_all_by_customer_id
    ir = InvoiceRepository.new('./data/invoices.csv', self)
    invoices = ir.find_all_by_customer_id(880)

    assert_instance_of Array, invoices
    assert_equal 6, invoices.count
  end

  def test_invoice_repo_find_all_by_customer_id_returns_empty_array_on_bad_search
    ir = InvoiceRepository.new('./data/invoices.csv', self)
    invoices = ir.find_all_by_customer_id(999999)

    assert_instance_of Array, invoices
    assert_equal [], invoices
  end

  def test_invoice_repo_can_find_all_by_merchant_id
    ir = InvoiceRepository.new('./data/invoices.csv', self)
    invoices = ir.find_all_by_merchant_id(12334372)

    assert_instance_of Array, invoices
    assert_equal 16, invoices.count
  end

  def test_invoice_repo_find_alla_by_merchant_id_returns_empty_array_on_bad_search
    ir = InvoiceRepository.new('./data/invoices.csv', self)
    invoices = ir.find_all_by_merchant_id(99999999)

    assert_instance_of Array, invoices
    assert_equal [], invoices
  end

  def test_invoice_repo_can_find_all_by_status
    ir = InvoiceRepository.new('./data/invoices.csv', self)
    invoices = ir.find_all_by_status("shipped")

    assert_instance_of Array, invoices
    assert_equal 2839, invoices.count
  end

  def test_invoice_repo_find_all_by_status_returns_empty_array_on_bad_search
    ir = InvoiceRepository.new('./data/invoices.csv', self)
    invoices = ir.find_all_by_status("asdjadls;k")

    assert_instance_of Array, invoices
    assert_equal [], invoices
  end

  def test_invoice_repo_to_se_merchant
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"
    })
    invoices = se.invoices
    merchant = invoices.invoice_repo_to_se_merchant(12335119)

    assert_instance_of Merchant, merchant
  end

end
