require 'time'
require_relative 'test_helper'
require_relative '../lib/fileio'
require_relative '../lib/invoice'
require_relative '../lib/invoice_repository'

# Test for the InvoiceRepository class
class InvoiceRepositoryTest < Minitest::Test
  def setup
    invoice_data = %(id,customer_id,merchant_id,status,created_at,updated_at
      1,1,12335938,pending,2009-02-07,2014-03-15
      2,1,12334753,shipped,2012-11-23,2013-04-14
      3,1,12335955,shipped,2009-12-09,2010-07-10
      4,1,12334269,pending,2013-08-05,2014-06-06
      5,1,12335311,pending,2014-02-08,2014-07-22
      6,1,12334389,pending,2015-03-13,2015-04-05
      7,1,12335009,pending,2006-10-16,2013-12-24
      8,1,12337139,shipped,2003-11-07,2004-07-31
      9,2,12336965,shipped,2003-03-07,2008-10-09
      10,2,12334839,pending,2014-04-13,2015-01-20
      25,6,12334264,returned,2011-08-08,2015-07-21
      37,9,12334873,returned,2009-08-31,2015-01-01)
    # file_path = FileIO.load('./test/fixtures/test_invoices.csv')
    csv = CSV.parse(invoice_data, headers: :true, header_converters: :symbol)
    @inv_repo = InvoiceRepository.new(csv)
    @invoice1 = @inv_repo.invoices[1]
    @invoice2 = @inv_repo.invoices[2]
    @invoice3 = @inv_repo.invoices[3]
    @invoice4 = @inv_repo.invoices[4]
    @invoice5 = @inv_repo.invoices[5]
    @invoice6 = @inv_repo.invoices[6]
    @invoice7 = @inv_repo.invoices[7]
    @invoice8 = @inv_repo.invoices[8]
    @invoice9 = @inv_repo.invoices[9]
    @invoice10 = @inv_repo.invoices[10]
    @invoice25 = @inv_repo.invoices[25]
    @invoice37 = @inv_repo.invoices[37]
    # @new_invoice = @inv_repo.create(
    #   customer_id: '7',
    #   merchant_id: '12334105',
    #   status: 'pending',
    #   created_at: '2009-12-09 12:08:04 UTC',
    #   updated_at: '2010-12-09 12:08:04 UTC'
    # )
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @inv_repo
  end

  def test_creating_an_index_of_invoices_from_data
    # assert_instance_of Hash, @inv_repo.invoices
    # assert_instance_of Invoice, @inv_repo.invoices[1]
    # assert_instance_of Invoice, @inv_repo.invoices[2]
    # assert_instance_of Invoice, @inv_repo.invoices[3]
    expected = { 1 => @invoice1, 2 => @invoice2,
                 3 => @invoice3, 4 => @invoice4,
                 5 => @invoice5, 6 => @invoice6,
                 7 => @invoice7, 8 => @invoice8,
                 9 => @invoice9, 10 => @invoice10,
                 25 => @invoice25, 37 => @invoice37 }
    assert_equal expected, @inv_repo.invoices
  end

  def test_all_returns_an_array_of_all_invoice_instances
    expected = [@invoice1, @invoice2, @invoice3,
                @invoice4, @invoice5, @invoice6,
                @invoice7, @invoice8, @invoice9,
                @invoice10, @invoice25, @invoice37]
    assert_instance_of expected, @inv_repo.all
  end

  # Left off here
  # =============

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
    assert_equal Time.parse('2009-02-07'), actual_one.created_at
    assert_equal Time.parse('2012-11-23'), actual_two.created_at
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
    assert_instance_of Invoice, actual_pending[0]
    assert_instance_of Invoice, actual_shipped[0]
    pending_ids = actual_pending.map(&:id)
    assert_equal [1, 4, 5, 6, 7, 10, 38], pending_ids
    shipped_ids = actual_shipped.map(&:id)
    assert_equal [2, 3, 8, 9], shipped_ids
  end

  def test_it_can_generate_next_invoice_id
    expected = 39
    actual = @inv_repo.create_new_id
    assert_equal expected, actual
  end

  def test_can_create_new_invoice
    assert_equal 13, @inv_repo.invoices.count
    assert_instance_of Invoice, @new_invoice
    assert_equal @new_invoice, @inv_repo.invoices[38]
  end

  def test_invoice_can_be_updated
    @inv_repo.update(38, status: 'shipped')
    assert_equal :shipped, @inv_repo.invoices[38].status
  end

  def test_invoice_can_be_deleted
    @inv_repo.delete(38)
    assert_equal 12, @inv_repo.invoices.count
    assert_nil @inv_repo.invoices[38]
  end

  def test_find_all_by_created_date
    result = @inv_repo.find_all_by_created_date(Time.parse('2012-11-23'))
    assert(result.all? { |each_result| each_result.class == Invoice })
    assert_equal [12334753], result.map(&:merchant_id)
  end
end
