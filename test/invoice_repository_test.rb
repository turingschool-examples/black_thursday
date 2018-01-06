require_relative 'test_helper'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test

  def test_it_exists
    ir = InvoiceRepository.new

    assert_instance_of InvoiceRepository, ir
  end

  def test_it_returns_all_invoices
    ir = InvoiceRepository.new
    all_invoices = ir.all

    assert_instance_of Invoice
  end

end
