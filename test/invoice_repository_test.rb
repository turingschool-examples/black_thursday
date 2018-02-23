require './test/test_helper'
require './lib/invoice_repository'
require './lib/sales_engine'
require './lib/searching'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    file_name = './data/sample_data/invoices.csv'
    @invoice_repo = InvoiceRepository.new(file_name)
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @invoice_repo
  end

  def	test_it_finds_invoice_id
    assert_instance_of Array, @invoice_repo.all
    assert_nil @invoice_repo.find_by_id(10)
    assert_instance_of Invoice, @invoice_repo.find_by_id(4)
  end

  def test_it_can_find_all_by_customer_id
    assert_equal [], @invoice_repo.find_all_by_customer_id('20')
    assert_instance_of Array, @invoice_repo.find_all_by_customer_id('1')
    assert_instance_of Invoice, @invoice_repo.find_all_by_customer_id(1)[0]
    assert_equal :shipped, @invoice_repo.find_all_by_customer_id(1)[0].status
  end

  def test_it_can_find_all_by_status
    assert_equal [], @invoice_repo.find_all_by_status('dropped')
    assert_instance_of Array, @invoice_repo.find_all_by_status('shipped')
    assert_equal 2, @invoice_repo.find_all_by_status('pending').length
    assert_equal 2, @invoice_repo.find_all_by_status('shipped').length
  end

  def test_inspect
    assert_equal @invoice_repo, @invoice_repo.inspect
    refute @invoice_repo.inspect.to_s.length > 50
  end
end
