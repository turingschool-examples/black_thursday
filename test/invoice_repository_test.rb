require './test/test_helper'
require './lib/invoice_repository'
require './lib/sales_engine'
require './lib/searching'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    file_name = './data/sample_data/invoices.csv'
    sales_eng = stub(
      find_invoice_merchant: mock('merchant'),
      find_invoice_items: [mock('item'), mock('item')],
      find_invoice_customer: mock('customer'),
      find_invoice_transactions: [mock, mock]
    )
    @invoice_repo = InvoiceRepository.new(file_name, sales_eng)
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @invoice_repo
  end

  def	test_it_finds_id
    assert_instance_of Array, @invoice_repo.all
    assert_nil @invoice_repo.find_by_id(10)
    assert_instance_of Invoice, @invoice_repo.find_by_id(4)
  end

  def test_it_can_find_all_by_customer_id
    actual  = @invoice_repo.find_all_by_customer_id('20')
    actual2 = @invoice_repo.find_all_by_customer_id(1)

    assert_equal [], actual
    assert_instance_of Array, actual2
    assert_instance_of Invoice, actual2[0]
    assert_equal :pending, actual2[0].status
  end

  def test_it_can_find_all_by_status
    actual  = @invoice_repo.find_all_by_status(:dropped)
    actual2 = @invoice_repo.find_all_by_status(:shipped)

    assert_equal [], actual
    assert_instance_of Array, actual2
    assert_equal 2, actual2.length
    assert_equal 2, actual2.length
  end

  def test_it_asks_parent_for_merchant
    assert_instance_of Mocha::Mock, @invoice_repo.merchant('id')
  end

  def test_it_asks_parent_for_items
    assert_instance_of Mocha::Mock, @invoice_repo.items('id')[0]
  end

  def test_it_asks_parent_for_customers
    assert_instance_of Mocha::Mock, @invoice_repo.customer('id')
  end

  def test_it_asks_parent_for_transactions
    assert_instance_of Mocha::Mock, @invoice_repo.transactions('id')[0]
  end

  def test_inspect
    expected = '#<InvoiceRepository 4 rows>'
    assert_equal expected, @invoice_repo.inspect
  end
end
