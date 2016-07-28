require './test/test_helper'
require './lib/sales_engine'

class InvoiceTest < Minitest::Test

  def test_that_it_has_an_id
    invoice = Invoice.new({ id: 10, customer_id: 2, merchant_id: 12334839, status: "pending", created_at: "2016-07-26 02:23:16 UTC", updated_at: "1970-04-01 12:45:13 UTC" })

    assert_equal 10, invoice.id
  end

  def test_that_it_has_a_customer_id
    invoice = Invoice.new({ id: 10, customer_id: 2, merchant_id: 12334839, status: "pending", created_at: "2016-07-26 02:23:16 UTC", updated_at: "1970-04-01 12:45:13 UTC" })

    assert_equal 2, invoice.customer_id
  end

  def test_that_it_has_a_merchant_id
    invoice = Invoice.new({ id: 10, customer_id: 2, merchant_id: 12334839, status: "pending", created_at: "2016-07-26 02:23:16 UTC", updated_at: "1970-04-01 12:45:13 UTC" })

    assert_equal 12334839, invoice.merchant_id
  end

  def test_that_it_has_a_status
    invoice = Invoice.new({ id: 10, customer_id: 2, merchant_id: 12334839, status: "pending", created_at: "2016-07-26 02:23:16 UTC", updated_at: "1970-04-01 12:45:13 UTC" })

    assert_equal "pending", invoice.status
  end

  def test_that_it_finds_when_created
    invoice = Invoice.new({ id: 10, customer_id: 2, merchant_id: 12334839, status: "pending", created_at: "2016-07-26 02:23:16 UTC", updated_at: "1970-04-01 12:45:13 UTC" })

    assert_equal Time.new(2016, 07, 26, 02, 23, 16, "-00:00"), invoice.created_at
  end

  def test_that_it_finds_when_updated
    invoice = Invoice.new({ id: 10, customer_id: 2, merchant_id: 12334839, status: "pending", created_at: "2016-07-26 02:23:16 UTC", updated_at: "1970-04-01 12:45:13 UTC" })

    assert_equal Time.new(1970, 04, 01, 12, 45, 13, "-00:00"), invoice.updated_at
  end

  def test_an_invoice_points_to_its_merchant
    se = SalesEngine.from_csv({ items: "./data/item_sample.csv", merchants: "./data/merchants_sample.csv" })
    invoice = se.invoices.find_by_id(100)

    assert_equal 12334266, invoice.merchant.id
  end
end
