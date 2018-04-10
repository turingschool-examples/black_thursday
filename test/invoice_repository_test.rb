require_relative 'test_helper'
require_relative '../lib/fileio'
require_relative '../lib/invoice'
require_relative '../lib/invoice_repository'

# Test for the InvoiceRepository class
class InvoiceRepositoryTest < Minitest::Test
  def setup
    file_path = FileIO.load('./test/fixtures/test_invoices.csv')
    @inv_repo = InvoiceRepository.new(file_path)
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @inv_repo
  end
end
