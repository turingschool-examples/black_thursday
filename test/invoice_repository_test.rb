require_relative 'test_helper'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < MiniTest::Test

  def test_all_contains_all_invoice_objects
    invoice_repo = InvoiceRepository.new

    invoice_repo.populate('./test/fixtures/invoices_fixture.csv')

    assert_instance_of Array, invoice_repo.all
    assert_instance_of Invoice, invoice_repo.all.first
    assert_equal 4, invoice_repo.all.count
  end


end
