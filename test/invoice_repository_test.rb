require 'bigdecimal'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_repository'
require 'pry'

class InvoiceRepositoryTest < MiniTest::Test

  def test_it_can_find_by_id
    ir = InvoiceRepository.new('./test/data/invoices_fixture.csv', sales_engine = nil)
    id = 2
    invoice = ir.find_by_id(id)

    assert_equal invoice.id, id
    assert_instance_of Invoice, invoice
  end

  def test_find_by_all_by_customer_id
    ir = InvoiceRepository.new('./test/data/invoices_fixture.csv', sales_engine = nil)
    results = ir.find_all_by_customer_id(1)

    assert_equal 1, results.count
  end




end
