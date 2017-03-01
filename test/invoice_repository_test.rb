require './test/test_helper.rb'
require 'pry'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    @invoice_csv =  './test/fixtures/invoices.csv'
    @parent = ""
  end
  def test_it_exists
    assert_instance_of InvoiceRepository, InvoiceRepository.new('./test/fixtures/invoices.csv', nil)
  end

  def test_all_array
    repo = InvoiceRepository.new(@invoice_csv, @parent)
    # repo.make_repository
    assert_equal 4985, repo.all.length
  end

  def test_finds_by_id
    repo = InvoiceRepository.new(@invoice_csv, @parent)
    assert_equal Invoice, repo.find_by_id(4).class
    assert_nil repo.find_by_id(0)
  end

  def test_finds_all_customer_id
    repo = InvoiceRepository.new(@invoice_csv, @parent)
    assert_equal 8, repo.find_all_by_customer_id(1).length
    assert_equal [], repo.find_all_by_customer_id(0)
  end

  def test_finds_all_merchant_id
    repo = InvoiceRepository.new(@invoice_csv, @parent)
    assert_equal 16, repo.find_all_by_merchant_id(12335938).length
    assert_equal [], repo.find_all_by_merchant_id(0)
  end

  def test_finds_all_status
    repo = InvoiceRepository.new(@invoice_csv, @parent)
    assert_equal 2839, repo.find_all_by_status("shipped").length
    assert_equal [], repo.find_all_by_status('')
  end

  def test_find_all_by_date
    repo = InvoiceRepository.new(@invoice_csv, @parent)
    assert_equal 1, repo.find_all_by_date(Time.parse('2012-08-26')).length
  end
end