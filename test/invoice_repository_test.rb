require_relative 'test_helper'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    invoice_csv = './test/fixtures/invoices_list_truncated.csv'
    parent = 'parent'
    @invoices = InvoiceRepository.new(invoice_csv, parent)
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @invoices
  end
end
