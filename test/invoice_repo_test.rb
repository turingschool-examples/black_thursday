require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_repo'


class InvoiceRepositoryTest < MiniTest::Test

  def test_it_exists
    invoice_repo = InvoiceRepository.new
    assert_instance_of InvoiceRepository, invoice_repo
  end

  def test_it_has_attributes
    invoice_repo = InvoiceRepository.new
    assert_equal 4985, invoice_repo.invoices.count
  end
end
