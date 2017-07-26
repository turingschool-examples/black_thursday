require './test/test_helper'
require './lib/invoice_repo'

class InvoiceRepositoryTest < Minitest::Test

  def test_it_exist
    invoice_repo = InvoiceRepository.new("./data/invoices.csv", "engine")

    assert_instance_of InvoiceRepository, invoice_repo
  end




end
