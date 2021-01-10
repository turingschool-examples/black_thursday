require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_repo'
require './lib/cleaner'

class InvoiceRepositoryTest < MiniTest::Test

  def setup
    @invoice_repo = InvoiceRepository.new
    @cleaner = Cleaner.new
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @invoice_repo
  end

  def test_it_has_attributes
    skip
    assert_equal [], @invoice_repo.invoices
  end

  def test_it_returns_all_invoices
    assert_equal 4985, @invoice_repo.all.length
  end

end
