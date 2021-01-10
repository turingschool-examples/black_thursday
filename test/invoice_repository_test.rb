require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice'
require './lib/invoice_repository'
require './lib/sales_engine'

class InvoiceRepositoryTest < Minitest::Test

  def setup
    @ir = InvoiceRepository.new('./data/invoices.csv')
  end

  def test_it_has_attributes
    assert_instance_of InvoiceRepository, @ir
    assert_equal './data/invoices.csv', @ir.path
  end

  def test_it_read_invoices
    assert_equal 4985, @ir.invoices.count
  end

  def test_returns_all
    assert_equal 4985, @ir.all.count
  end

  def test_find_by_id_returns_correct_invoice
    invoice = @ir.find_by_id(3452)

    assert_equal 12_335_690, invoice.merchant_id
  end

  

  def test_find_by_merchant_id_returns_correct_invoice
    invoices = @ir.find_all_by_merchant_id(12_335_690)

    assert_equal 16, invoices.length
  end

end
