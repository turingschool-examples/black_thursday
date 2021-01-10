require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice'
require './lib/invoice_repository'
require './lib/sales_engine'

class InvoiceRepositoryTest < Minitest::Test
  def test_it_has_attributes
    ir = InvoiceRepository.new('./data/invoices.csv')

    assert_instance_of InvoiceRepository, ir
    assert_equal './data/invoices.csv', ir.path
  end
end
