require_relative "test_helper"
require_relative "../lib/invoice"
require_relative "../lib/sales_engine"

class InvoiceTest < Minitest::Test

  def test_it_exist
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
      })

      i = Invoice.new({id: 5, customer_id: 1, merchant_id: 12335311, status: "pending", created_at: "2014-02-08", updated_at: "2014-07-22"}, se)

      assert_instance_of Invoice, i
  end

  def test_it_has_attributes
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    i = Invoice.new({id: 5, customer_id: 1, merchant_id: 12335311, status: "pending", created_at: "2014-02-08", updated_at: "2014-07-22"}, se)

    assert_equal 5, i.id
    assert_equal 1, i.customer_id
    assert_equal 12335311, i.merchant_id
    assert_equal :pending, i.status
    assert_instance_of Time, i.created_at
    assert_equal "2014-02-08 00:00:00 -0700", i.created_at.to_s
    assert_instance_of Time, i.updated_at
    assert_equal "2014-07-22 00:00:00 -0600", i.updated_at.to_s
  end

  def test_invoice_repo_returns_instance_merchant_by_id
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    ir = InvoiceRepo.new(se, "./test/fixtures/invoices_truncated.csv")
    i  = ir.invoices.first

    assert_instance_of Invoice, i
    assert_instance_of Merchant, i.merchant
    assert_equal 12334105, i.merchant.id
  end

  def test_items_returns_items_of_invoice
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    i = Invoice.new({id: 5, customer_id: 1, merchant_id: 12335311, status: "pending", created_at: "2014-02-08", updated_at: "2014-07-22"}, se)

    assert_instance_of Array, i.items
    i.items.each do |item|
      assert_instance_of Item, item
    end
  end

  def test_transactions_returns_transactions_of_invoice
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    i = Invoice.new({id: 5, customer_id: 1, merchant_id: 12335311, status: "pending", created_at: "2014-02-08", updated_at: "2014-07-22"}, se)

    assert_instance_of Array, i.transactions
    i.transactions.each do |transaction|
      assert_instance_of Transaction, transaction
      assert_equal 5, transaction.invoice_id
    end
  end

  def test_customer_returns_customer_of_invoice
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    i = Invoice.new({id: 5, customer_id: 1, merchant_id: 12335311, status: "pending", created_at: "2014-02-08", updated_at: "2014-07-22"}, se)

    assert_instance_of Customer, i.customer
    assert_equal 1, i.customer.id
  end

  def test_successful_transactions_returns_successful_transactions
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    i = Invoice.new({id: 5, customer_id: 1, merchant_id: 12335311, status: "pending", created_at: "2014-02-08", updated_at: "2014-07-22"}, se)
    i2 = Invoice.new({id: 1752, customer_id: 348, merchant_id: 12334174, status: "shipped", created_at: "2002-09-01", updated_at: "2003-08-11"}, se)

    assert i.successful_transactions
    refute i2.successful_transactions
  end

  def test_is_paid_in_full_returns_true_or_false
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    i = Invoice.new({id: 74, customer_id: 14, merchant_id: 12334105, status: "returned", created_at: "2014-02-08", updated_at: "2014-07-22"}, se)
    i2 = Invoice.new({id: 1752, customer_id: 348, merchant_id: 12334174, status: "shipped", created_at: "2002-09-01", updated_at: "2003-08-11"}, se)

    refute i.is_paid_in_full?
    refute i2.is_paid_in_full?
  end

  def test_total_invoice_items_price_returns_total_price_of_invoice
    se = SalesEngine.from_csv({
      :items         => "./test/fixtures/items_truncated.csv",
      :merchants     => "./test/fixtures/merchants_truncated.csv",
      :invoices      => "./test/fixtures/invoices_truncated.csv",
      :invoice_items => "./test/fixtures/invoice_items_truncated.csv",
      :transactions  => "./test/fixtures/transactions_truncated.csv",
      :customers     => "./test/fixtures/customers_truncated.csv"
    })

    i = Invoice.new({id: 74, customer_id: 14, merchant_id: 12334105, status: "returned", created_at: "2014-02-08", updated_at: "2014-07-22"}, se)

    assert_instance_of BigDecimal, i.total
    assert_equal 0.1449662e5, i.total
  end
end
