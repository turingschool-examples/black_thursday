require './test_helper'
require './lib/invoice'
require './lib/invoice_repository'
require './lib/file_loader'
require './lib/sales_engine'
require 'bigdecimal'
require 'pry'

class InvoiceRepositoryTest < MiniTest::Test
  def setup
    se = SalesEngine.from_csv({
    :items => "./data/item_sample.csv",
    :merchants => "./data/merchant_sample.csv",
    :invoices => "./data/invoices.csv"
    })

    @ir = se.invoices
  end

  def test_it_returns_array_of_all_invoices
    assert_equal 4985, @ir.all.length
  end

  def test_it_can_find_by_invoice_id
    invoice = @ir.find_by_id(3452)

    assert_instance_of Invoice, invoice
    assert_equal 3452, invoice.id
    assert_equal 12335690, invoice.merchant_id
    assert_equal 679, invoice.customer_id
    assert_equal :pending, invoice.status
  end

  def test_it_returns_nill_if_you_try_to_find_nonexistant_invoice
    assert_nil @ir.find_by_id(5000)
  end

  def test_it_can_find_all_by_customer_id
    assert_equal 10, @ir.find_all_by_customer_id(300).length
  end

  def test_it_returns_empty_array_if_customer_doesnt_exist
    assert_equal [], @ir.find_all_by_customer_id(1000)
  end

  def test_it_can_find_all_by_merchant_id
    assert_equal 7, @ir.find_all_by_merchant_id(12335080).length
  end

  def test_it_returns_empty_array_if_merchant_doesnt_exist
    assert_equal [], @ir.find_all_by_merchant_id(1000)
  end

  def test_it_can_find_all_by_status
    assert_equal 2839, @ir.find_all_by_status(:shipped).length
    assert_equal 1473, @ir.find_all_by_status(:pending).length
  end

  def test_it_returns_empty_array_if_status_is_sold
    assert_equal [], @ir.find_all_by_status(:sold)
  end
end
