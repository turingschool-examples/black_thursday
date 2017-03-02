require './test/test_helper'

class InvoiceTest < Minitest::Test

  attr_reader :invoice_1, :se

  def setup

    @se = SalesEngine.from_csv({
      :merchants    => "./data/merchants.csv",
      :items        => "./data/items.csv",
      :invoices     => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers    => "./data/customers.csv"
      })
    @invoice_1 = Invoice.new({:id => "2", :customer_id => "1", :merchant_id => "12334753", :status => "shipped",:created_at => "2012-11-23", :updated_at => "2013-04-14" })
  end

  def test_it_exits
    assert_instance_of Invoice, invoice_1
  end

  def test_has_id
    assert_equal 2, invoice_1.id
  end

  def test_has_customer_id
    assert_equal 1, invoice_1.customer_id
  end

  def test_has_merchant_id
    assert_equal 12334753, invoice_1.merchant_id
  end

  def test_has_status
    assert_equal :shipped, invoice_1.status
  end

  def test_has_created_at
    assert_instance_of Time, invoice_1.created_at
  end

  def test_has_update_at
    assert_instance_of Time, invoice_1.updated_at
  end

  def test_merchant
    assert_instance_of Merchant, se.invoices.invoices.first.merchant
    assert_equal 12335938, se.invoices.invoices.first.merchant.id
  end

  def test_items
    assert_instance_of Array, se.invoices.invoices.first.items
    assert_equal 8, se.invoices.invoices.first.items.count
  end

  def test_is_paid_in_full?
    assert se.invoices.invoices.first.is_paid_in_full?
  end

  def test_mod_paid_in_full?
    assert se.invoices.invoices.first.mod_paid_in_full?
  end

  def test_total
    assert_instance_of BigDecimal, se.invoices.invoices.first.total
    assert_equal 21067.77, se.invoices.invoices.first.total.to_f
  end
end
