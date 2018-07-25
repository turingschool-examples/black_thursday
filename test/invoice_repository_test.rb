require './test/test_helper'
require './lib/invoice_repository'

class InvoiceRepositoryTest << Minitest::Test

  def test_it_exists
    invoice_repo = InvoiceRepository.new

    assert_instance_of InvoiceRepository, invoice_repo
  end
end
