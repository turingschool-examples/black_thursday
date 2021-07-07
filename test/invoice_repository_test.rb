# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    @invoice1 = Invoice.new(id: 1,
                            customer_id: 1,
                            merchant_id: 12_335_938,
                            status: 'pending',
                            created_at: '2009-02-07',
                            updated_at: '2014-03-1')
    @invoice2 = Invoice.new(id: 2,
                            customer_id: 1,
                            merchant_id: 12_335_938,
                            status: 'shipped',
                            created_at: '2012-11-23',
                            updated_at: '2013-04-14')
    @invoice3 = Invoice.new(id: 3,
                            customer_id: 1,
                            merchant_id: 12_335_955,
                            status: 'shipped',
                            created_at: '2009-12-09',
                            updated_at: '2010-07-10')
    @invoice4 = Invoice.new(id: 4,
                            customer_id: 1,
                            merchant_id: 12_334_269,
                            status: 'pending',
                            created_at: '2013-08-05',
                            updated_at: '2014-06-06')
    @invoice_repository = InvoiceRepository.new
    @invoice_repository.all << @invoice1
    @invoice_repository.all << @invoice2
    @invoice_repository.all << @invoice3
    @invoice_repository.all << @invoice4
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @invoice_repository
  end

  def test_all_returns_all_invoices
    expected = [@invoice1, @invoice2, @invoice3, @invoice4]
    actual = @invoice_repository.all

    assert_equal expected, actual
  end

  def test_it_finds_all_by_status
    expected = [@invoice1, @invoice4]
    actual = @invoice_repository.find_all_by_status(:pending)

    assert_equal expected, actual
  end
  def test_it_finds_all_by_merchant_id
    expected = [@invoice1, @invoice2]
    actual = @invoice_repository.find_all_by_merchant_id(12_335_938)

    assert_equal expected, actual
  end

  def test_it_finds_all_by_customer_id
    expected = [@invoice1, @invoice2, @invoice3, @invoice4]
    actual = @invoice_repository.find_all_by_customer_id(1)

    assert_equal expected, actual
  end

  def test_it_updates
    greater_than_time = Time.now
    @invoice_repository.update(1, status: :shipped)

    expected = :shipped
    actual = @invoice_repository.find_by_id(1).status

    assert_equal expected, actual
    updated_time = @invoice_repository.find_by_id(1).updated_at
    assert updated_time > greater_than_time
  end

  def test_it_can_create
    invoice = @invoice_repository.create(id: 5,
                                         customer_id: 1,
                                         merchant_id: 12_335_938,
                                         status: 'pending',
                                         created_at: '2009-02-07',
                                         updated_at: '2014-03-1')

    expected = 5
    actual = invoice.last.id

    assert_equal expected, actual
    @invoice_repository.delete(5)
  end

  def test_it_counts_number_of_merchants
    skip
    expected = 3
    actual = @invoice_repository.number_of_merchants

    assert_equal expected, actual
  end

  def test_it_groups_invoices_by_merchant
    skip
    expected = {12_335_938 => [@invoice1, @invoice2],
                12_335_955 => [@invoice3],
                12_334_269 => [@invoice4]}
    actual = @invoice_repository.group_invoices_by_merchant_id

    assert_equal expected, actual
  end

  def test_it_calculates_average_invoices_per_merchant
    skip
    expected = 1.33
    actual = @invoice_repository.average_invoices_per_merchant

    assert_equal expected, actual
  end

  def test_it_groups_by_day
    skip
    expected = [@invoice2]
    actual = @invoice_repository.group_by_day['Friday']

    assert_equal expected, actual
  end

  def test_average_invoices_per_day
    skip
    expected = 0.57
    actual = @invoice_repository.average_invoices_per_day

    assert_equal expected, actual
  end

  def test_it_calculates_percentage_by_status
    skip
    expected = 50.0
    actual = @invoice_repository.invoice_status(:shipped)

    assert_equal expected, actual
  end
end
