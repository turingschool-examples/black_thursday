require_relative 'test_helper'
require_relative '../lib/invoice_repository'

# This is a class for tests of the invoice repo class.
class InvoiceRepositoryTest < Minitest::Test
  def setup
    invoice_csv = './test/fixtures/invoices_list_truncated.csv'
    parent = 'parent'
    @invoice_repo = InvoiceRepository.new(invoice_csv, parent)
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @invoice_repo
  end

  def test_all_invoices
    assert_instance_of Invoice, @invoice_repo.all.first
    assert_equal 26, @invoice_repo.all.length
  end

  def test_find_by_id
    assert_instance_of Invoice, @invoice_repo.find_by_id(19)
    assert_equal 123_343_72, @invoice_repo.find_by_id(19).merchant_id
    assert_nil @invoice_repo.find_by_id(21)
  end

  def test_find_all_by_customer_id
    assert_instance_of Array, @invoice_repo.find_all_by_customer_id(1)
    assert_equal 8, @invoice_repo.find_all_by_customer_id(1).length
    assert_instance_of Invoice, @invoice_repo.find_all_by_customer_id(1).first
    assert_equal [], @invoice_repo.find_all_by_customer_id(35)
  end

  def test_find_all_by_merchant_id
    assert_instance_of Array, @invoice_repo.find_all_by_merchant_id(123_350_09)
    assert_equal 1, @invoice_repo.find_all_by_merchant_id(123_350_09).length
    actual = @invoice_repo.find_all_by_merchant_id(123_350_09).first
    assert_instance_of Invoice, actual
    assert_equal [], @invoice_repo.find_all_by_merchant_id(123)
  end

  def test_find_all_by_status
    assert_instance_of Array, @invoice_repo.find_all_by_status(:shipped)
    assert_equal 9, @invoice_repo.find_all_by_status(:pending).length
    assert_instance_of Invoice, @invoice_repo.find_all_by_status(:shipped).first
    assert_equal [], @invoice_repo.find_all_by_status(:dummy_symbol)
  end

  def test_find_all_by_date
    date = Time.parse('2005-01-03')
    assert_instance_of Array, @invoice_repo.find_all_by_date(date)
    assert_equal 1, @invoice_repo.find_all_by_date(date).length
    assert_instance_of Invoice, @invoice_repo.find_all_by_date(date).first
    assert_equal [], @invoice_repo.find_all_by_date(Time.parse('2000-01-01'))
  end

  def test_inspect
    assert_equal '#<InvoiceRepository 26 rows>', @invoice_repo.inspect
  end
end
