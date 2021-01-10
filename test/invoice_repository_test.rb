require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice'
require './lib/invoice_repository'
require './lib/sales_engine'

class InvoiceRepositoryTest < Minitest::Test

  def setup
    @ir = InvoiceRepository.new('./data/invoices.csv')
  end

  def test_it_has_attributes
    assert_instance_of InvoiceRepository, @ir
    assert_equal './data/invoices.csv', @ir.path
  end

  def test_it_read_invoices
    assert_equal 4985, @ir.invoices.count
  end

  def test_returns_all
    assert_equal 4985, @ir.all.count
  end

  def test_find_by_id_returns_correct_invoice
    invoice = @ir.find_by_id(3452)

    assert_equal 12_335_690, invoice.merchant_id
  end

  def test_find_by_customer_id_returns_correct_invoices
    invoices = @ir.find_all_by_customer_id(300)

    assert_equal 10, invoices.length
  end

  def test_find_by_merchant_id_returns_correct_invoices
    invoices = @ir.find_all_by_merchant_id(12_335_690)

    assert_equal 16, invoices.length
  end

  def test_find_all_by_status
    invoices = @ir.find_all_by_status(:shipped)

    assert_equal 2839, invoices.length
  end

  def test_create_invoice
    invoice = @ir.create({
  :customer_id => 7,
  :merchant_id => 8,
  :status      => "pending",
  :created_at  => Time.now.to_s,
  :updated_at  => Time.now.to_s,
  })

  assert_equal 8, @ir.find_by_id(4986).merchant_id
  end

  def test_update_invoice
    @ir.update(3452, {:status => :shipped})

  assert_equal :shipped, @ir.find_by_id(3452).status
  end

end
