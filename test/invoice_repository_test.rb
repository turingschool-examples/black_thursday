require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_repository'
require './lib/invoice'
require './lib/sales_engine'

class InvoiceRepositoryTest < MiniTest::Test

  def setup
    #gonna contain stuff
  end

  def test_invoice_repo_exists
    invoice = InvoiceRepository.new("thing")

    assert_instance_of InvoiceRepository, invoice
  end
end
