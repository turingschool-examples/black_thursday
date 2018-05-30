require './test/test_helper'
require './lib/invoice_repository'
require './lib/invoice'
require 'csv'

class InvoiceRepositoryTest < Minitest::Test

  def setup
    @invoices = CSV.open './data/invoice_test_data.csv',
                          headers: true,
                          header_converters: :symbol
    @invoice_repository = InvoiceRepository.new
  end

  def test_exists
    assert_instance_of InvoiceRepository, @invoice_repository
  end

  def test_all_defaults_empty
    assert_equal [], @invoice_repository.all
  end

  def test_loads_csv
    @invoice_repository.load_invoices(@invoices)
    assert_equal 10, @invoice_repository.all.length
  end

  def test_invoice_can_be_found_by_id
    @invoice_repository.load_invoices(@invoices)

    assert_equal "12335938", @invoice_repository.find_by_id(1).merchant_id
    assert_nil @invoice_repository.find_by_id(123467)
  end

  def test_find_all_by_customer_id
    @invoice_repository.load_invoices(@invoices)

    assert_equal 8, @invoice_repository.find_all_by_customer_id(1).length
    assert_equal [], @invoice_repository.find_all_by_customer_id(23464)
  end

  def test_find_all_by_merchant_id
    @invoice_repository.load_invoices(@invoices)

    assert_equal 3, @invoice_repository.find_all_by_merchant_id(12335938).length
    assert_equal [], @invoice_repository.find_all_by_merchant_id(23464)
  end

  def test_find_all_by_status
    @invoice_repository.load_invoices(@invoices)

    assert_equal 6, @invoice_repository.find_all_by_status("pending").length
    assert_equal [], @invoice_repository.find_all_by_status("fake status")
  end

  def test_create
    @invoice_repository.load_invoices(@invoices)

    invoice = {
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    }

    @invoice_repository.create(invoice)

    assert_equal 11, @invoice_repository.all.length
    assert_equal 11, @invoice_repository.all[-1].id
  end

  def test_update
    @invoice_repository.load_invoices(@invoices)
    invoice = {
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    }
    @invoice_repository.create(invoice)
    time_before = @invoice_repository.all[-1].updated_at
    @invoice_repository.update(11, {status: "dazed and confused"})
    time_after = @invoice_repository.all[-1].updated_at

    assert_equal "dazed and confused", @invoice_repository.all[-1].status
    assert time_after > time_before
  end

  def test_delete
    @invoice_repository.load_invoices(@invoices)

    @invoice_repository.delete(5)

    assert_equal 9, @invoice_repository.all.length
  end

end