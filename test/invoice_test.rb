require_relative "test_helper"
require_relative "../lib/invoice"
require_relative "../lib/sales_engine"

 class InvoiceTest < Minitest::Test
 
   def test_it_exist
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    i = Invoice.new({id: 5, customer_id: 1, merchant_id: 12335311, status: "pending", created_at: "2014-02-08", updated_at: "2014-07-22"}, se)

     assert_instance_of Invoice, i 
   end

  def test_it_has_attributes
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
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
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    ir = InvoiceRepo.new(se, "./data/invoices.csv")
    i  = ir.invoices.first

    assert_instance_of Invoice, i
    assert_instance_of Merchant, i.merchant
    assert_equal 12335938, i.merchant.id
    assert_equal 12335938, i.merchant_id
  end

 end







