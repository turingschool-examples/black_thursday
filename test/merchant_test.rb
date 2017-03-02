require './test/test_helper'

class MerchantTest < Minitest::Test

  attr_reader :merchant, :se

  def setup
    @se = SalesEngine.from_csv({
    :merchants    => "./data/merchants.csv",
    :items        => "./data/items.csv",
    :invoices     => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv",
    :customers    => "./data/customers.csv"
    })
    @merchant = Merchant.new({id:"12334105",  name:"Shopin1901", created_at:"2010-12-10", updated_at:"2011-12-04"})
  end

  def test_class_exists
    assert_instance_of Merchant, merchant
  end

  def test_id
    assert_equal 12334105, merchant.id
  end

  def test_name
    assert_equal "Shopin1901", merchant.name
  end

  def test_created_at
    assert_equal Time.parse("2010-12-10"), merchant.created_at
  end

  def test_items
    assert_instance_of Array, se.merchants.merchants.first.items
    assert_instance_of Item, se.merchants.merchants.first.items.first
    assert_equal 3, se.merchants.merchants.first.items.count
  end

  def test_invoices
    assert_instance_of Array, se.merchants.merchants.first.invoices
    assert_instance_of Invoice, se.merchants.merchants.first.invoices.first
    assert_equal 10, se.merchants.merchants.first.invoices.count
  end

  def test_customers
    assert_instance_of Array, se.merchants.merchants.first.customers
    assert_equal 10, se.merchants.merchants.first.customers.count
  end

  def test_invoice_total
    assert_instance_of BigDecimal,se.merchants.merchants.first.invoice_total
    assert_equal 73777.17, se.merchants.merchants.first.invoice_total.to_f
  end
  def test_invoice_paid_in_full
    assert_equal 5, se.merchants.merchants.first.invoices_paid_in_full.count
  end

  def test_paid_full_total
    assert_instance_of BigDecimal, se.merchants.merchants.first.paid_in_full_total
    assert_equal 73777.17, se.merchants.merchants.first.paid_in_full_total.to_f
  end
end
