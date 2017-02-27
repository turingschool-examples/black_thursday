require './test/test_helper'
require './lib/invoice_repository'
require './lib/sales_engine'

class InvoiceRepositoryTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
      :invoices => "./data/invoices.csv",
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
    @ir = @se.invoices
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @ir
  end

  def test_all
    assert_equal 4985, @ir.all.count
    assert_equal 12335938, @ir.all.first.merchant_id
  end

  def test_find_by_id
    assert_instance_of Invoice, @ir.find_by_id(23)
    assert_equal 12336652, @ir.find_by_id(23).merchant_id
  end

  def test_find_all_by_customer_id
    assert_instance_of Invoice, @ir.find_all_by_customer_id(23).first
    assert_equal 5, @ir.find_all_by_customer_id(23).count
    assert_equal [], @ir.find_all_by_customer_id(00)
  end

  def test_find_all_by_merchant_id
    assert_instance_of Invoice, @ir.find_all_by_merchant_id(12336113).first
    assert_equal 9, @ir.find_all_by_merchant_id(12336113).count
    assert_equal [], @ir.find_all_by_merchant_id(100)
  end

  def test_find_all_by_status
    assert_equal 499, @ir.find_all_by_status("pending")
  end

  def test_find_merchant
    skip
    assert_equal "merchant name", @ir.merchant(22)

  end

end
