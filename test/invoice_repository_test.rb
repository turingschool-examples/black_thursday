require 'time'
require_relative 'test_helper'
require_relative '../lib/fileio'
require_relative '../lib/invoice'
require_relative '../lib/invoice_repository'

# Test for the InvoiceRepository class
class InvoiceRepositoryTest < Minitest::Test
  def setup
    file_path = FileIO.load('./test/fixtures/test_invoices.csv')
    @inv_repo = InvoiceRepository.new(file_path)
    @new_invoice = @inv_repo.create(
      customer_id: '7',
      merchant_id: '12334105',
      status: :pending,
      created_at: '2009-12-09 12:08:04 UTC',
      updated_at: '2010-12-09 12:08:04 UTC'
    )
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @inv_repo
  end

  def test_creating_an_index_of_invoices_from_data
    assert_instance_of Hash, @inv_repo.invoices
    assert_instance_of Invoice, @inv_repo.invoices[1]
    assert_instance_of Invoice, @inv_repo.invoices[2]
    assert_instance_of Invoice, @inv_repo.invoices[3]
  end

  def test_all_returns_an_array_of_all_invoice_instances
    assert_instance_of Array, @inv_repo.all
  end

  def test_all_returns_correct_ids
    all_invoices = @inv_repo.all
    actual_all_ids = all_invoices.map(&:id)
    expected = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 25, 37, 38]
    assert_equal expected, actual_all_ids
  end

  def test_all_returns_correct_customer_ids
    all_invoices = @inv_repo.all
    actual_all_cust_ids = all_invoices.map(&:customer_id)
    expected = [1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 6, 9, 7]
    assert_equal expected, actual_all_cust_ids
  end

  def test_can_find_by_id
    actual_one = @inv_repo.find_by_id(1)
    actual_two = @inv_repo.find_by_id(2)
    assert_instance_of Invoice, actual_one
    assert_instance_of Invoice, actual_two
    assert_equal '2009-02-07', actual_one.created_at
    assert_equal '2012-11-23', actual_two.created_at
  end

  def test_can_find_all_by_customer_id
    actual = @inv_repo.find_all_by_customer_id(2)
    result = actual.all? do |invoice|
      invoice.class == Invoice
    end
    assert result
    ids = actual.map(&:id)
    assert_equal [9, 10], ids
  end

  def test_can_find_all_by_merchant_id
    actual = @inv_repo.find_all_by_merchant_id(12335938)
    result = actual.all? do |invoice|
      invoice.class == Invoice
    end
    assert result
    ids = actual.map(&:id)
    assert_equal [1], ids
  end

  def test_can_find_all_by_status
    actual_pending = @inv_repo.find_all_by_status(:pending)
    actual_shipped = @inv_repo.find_all_by_status(:shipped)
    actual_returned = @inv_repo.find_all_by_status(:returned)
    assert_instance_of Invoice, actual_pending[0]
    assert_instance_of Invoice, actual_shipped[0]
    assert_instance_of Invoice, actual_returned[0]
    pending_ids = actual_pending.map(&:id)
    assert_equal [1, 4, 5, 6, 7, 10, 38], pending_ids
    shipped_ids = actual_shipped.map(&:id)
    assert_equal [2, 3, 8, 9], shipped_ids
    returned_ids = actual_returned.map(&:id)
    assert_equal [25, 37], returned_ids
  end

  def test_it_can_generate_next_invoice_id
    expected = 39
    actual = @inv_repo.create_new_id
    assert_equal expected, actual
  end

  def test_can_create_new_invoice
    assert_instance_of Invoice, @new_invoice
    assert_equal 13, @inv_repo.invoices.count
    assert_equal 7, @inv_repo.invoices[38].customer_id
    assert_equal 12334105, @inv_repo.invoices[38].merchant_id
    assert_equal :pending, @inv_repo.invoices[38].status
    assert_equal '2009-12-09 12:08:04 UTC', @inv_repo.invoices[38].created_at
    assert_equal '2010-12-09 12:08:04 UTC', @inv_repo.invoices[38].updated_at
  end

  def test_invoice_can_be_updated
    @inv_repo.update(38, status: :shipped)
    assert_equal :shipped, @inv_repo.invoices[38].status
    # assert_equal Time.now, @inv_repo.invoices[38].updated_at
  end

  def test_invoice_can_be_deleted
    @inv_repo.delete(38)
    assert_equal 12, @inv_repo.invoices.count
    assert_nil @inv_repo.invoices[38]
  end

  def test_find_all_by_crewated_date
    result = @inv_repo.find_all_by_created_date("2012-11-23")
    assert(result.all?{ |each_result| each_result.class == Invoice })
    assert_equal [12334753], result.map(&:merchant_id)
  end

  def test_find_all_by_day_of_week
    result = @inv_repo.find_all_by_day_of_week("saturday")
    assert(result.all?{ |each_result| each_result.class == Invoice })
    assert_equal [12335938, 12335311], result.map(&:merchant_id)
  end
end
