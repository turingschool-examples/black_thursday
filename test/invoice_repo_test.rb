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

  def test_it_can_find_by_id
    invoice_id = 3452
    expected = @invoice_repo.find_by_id(invoice_id)
    assert_equal invoice_id, expected.id
    assert_equal 12335690, expected.merchant_id
    assert_equal 679, expected.customer_id
    assert_equal :pending, expected.status

    invoice_id = 5000
    expected = @invoice_repo.find_by_id(invoice_id)
    assert_nil expected
  end
end
