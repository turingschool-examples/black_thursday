require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice'
require './lib/invoice_repository'
require 'bigdecimal'
require 'time'
require 'pry'

class InvoiceRepositoryTest < Minitest::Test

  def test_it_exists
    ir = InvoiceRepository.new("./data/invoices.csv")
    assert_instance_of InvoiceRepository, ir
  end

  def test_all_returns_array_of_all_invoices
    ir = InvoiceRepository.new("./data/invoices.csv")

    assert_instance_of Invoice, ir.all[0]
    assert_equal 4985, ir.all.count
  end

  def test_it_can_find_all_invoices_by_invoice_id
    ir = InvoiceRepository.new("./data/invoices.csv")
    assert_equal ir.all[3451], ir.find_by_id(3452)
    assert_equal nil, ir.find_by_id(5000)
  end

  def test_it_can_find_all_invoices_by_customer_id
    ir = InvoiceRepository.new("./data/invoices.csv")
    assert_equal 10, ir.find_all_by_customer_id(300).count
    assert_equal [], ir.find_all_by_customer_id(1000)
  end

  def test_it_can_find_all_invoices_by_merchant_id
    ir = InvoiceRepository.new("./data/invoices.csv")
    assert_equal 7, ir.find_all_by_merchant_id(12335080).count
    assert_equal [], ir.find_all_by_merchant_id(1000)
  end

  def test_it_can_find_all_invoices_by_status
    ir = InvoiceRepository.new("./data/invoices.csv")
    assert_equal 2839, ir.find_all_by_status(:shipped).count
    assert_equal 1473, ir.find_all_by_status(:pending).count
    assert_equal [], ir.find_all_by_status(:sold)
  end

  def test_that_it_can_create_an_invoice
    ir = InvoiceRepository.new("./data/invoices.csv")
    data = ({
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
      })
    actual = ir.create(data).last
    expected = ir.find_by_id(4986)
    assert_equal expected, actual
  end

  def test_it_can_update_an_existing_invoice
    ir = InvoiceRepository.new("./data/invoices.csv")
    data = ({
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
      })
    ir.create(data)
    ir.update(4986, {status: :success})
    updated_invoice = ir.all.last
    assert_equal "success" , updated_invoice.status
    assert_nil ir.update(5000, {})
  end

  def test_it_cannot_update_ids_on_an_invoice
    ir = InvoiceRepository.new("./data/invoices.csv")
    data = ({
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
      })
    ir.create(data)
    attributes = ({
      id: 5000,
      customer_id: 2,
      merchant_id: 3,
      created_at: Time.now
      })
    ir.update(4986, attributes)
    assert_equal nil, ir.find_by_id(5000)
    assert_equal ir.all[4985], ir.find_by_id(4986)
    updated_invoice = ir.all.last
    assert_equal 7 , updated_invoice.customer_id
    assert_equal 8 , updated_invoice.merchant_id
    created_at = ir.find_by_id(4986).created_at != attributes[:created_at]
    assert_equal true, created_at
  end

  def test_it_can_delete_an_invoice
    ir = InvoiceRepository.new("./data/invoices.csv")
    data = ({
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
      })
    ir.create(data)
    ir.delete(4986)
    assert_nil ir.find_by_id(4986)
    assert_nil ir.delete(5000)
  end
end
