require 'time'
require_relative 'test_helper'
require_relative '../lib/file_io'
require_relative '../lib/elementals/invoice'
require_relative '../lib/repositories/invoice_repository'

# Test for the InvoiceRepository class
class InvoiceRepositoryTest < Minitest::Test
  def setup
    invoice_data = invoices
    csv = parse_data(invoice_data)
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
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @inv_repo
  end

  def test_creating_an_index_of_invoices_from_data
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
    assert_equal expected, @inv_repo.all
  end

  def test_can_find_by_id
    actual_one = @inv_repo.find_by_id(1)
    actual_two = @inv_repo.find_by_id(2)
    assert_equal @invoice1, actual_one
    assert_equal @invoice2, actual_two
  end

  def test_can_find_all_by_customer_id
    actual = @inv_repo.find_all_by_customer_id(2)
    assert_equal [@invoice9, @invoice10], actual
  end

  def test_can_find_all_by_merchant_id
    actual = @inv_repo.find_all_by_merchant_id(12335938)
    assert_equal [@invoice1], actual
  end

  def test_can_find_all_by_status
    actual_pending = @inv_repo.find_all_by_status(:pending)
    actual_shipped = @inv_repo.find_all_by_status(:shipped)
    assert_equal [@invoice1, @invoice4, @invoice5,
                  @invoice6, @invoice7, @invoice10], actual_pending
    assert_equal [@invoice2, @invoice3, @invoice8, @invoice9], actual_shipped
  end

  def test_it_can_generate_next_invoice_id
    expected = 38
    actual = @inv_repo.create_new_id
    assert_equal expected, actual
  end

  def test_can_create_new_invoice
    a_new_invoice = new_invoice
    assert_equal 13, @inv_repo.invoices.count
    assert_equal a_new_invoice, @inv_repo.invoices[38]
  end

  def test_invoice_can_be_updated
    new_invoice
    @inv_repo.update(38, status: 'shipped')
    assert_equal :shipped, @inv_repo.invoices[38].status
  end

  def test_invoice_can_be_deleted
    new_invoice
    @inv_repo.delete(38)
    assert_equal 12, @inv_repo.invoices.count
    assert_nil @inv_repo.invoices[38]
  end

  def test_find_all_by_created_date
    result = @inv_repo.find_all_by_created_date(Time.parse('2012-11-23'))
    assert_equal [@invoice2], result
  end

  def new_invoice
    @inv_repo.create(
      customer_id: '7',
      merchant_id: '12334105',
      status: 'pending',
      created_at: '2009-12-09 12:08:04 UTC',
      updated_at: '2010-12-09 12:08:04 UTC'
    )
  end

  def invoices
    %(id,customer_id,merchant_id,status,created_at,updated_at
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
  end

  def parse_data(data)
    CSV.parse(data, headers: :true, header_converters: :symbol)
  end
end
