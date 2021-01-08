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
    assert_equal [], invoice_repo.invoices
  end
end
