require_relative "test_helper"
require_relative "../lib/customer"
require_relative "../lib/sales_engine"

class CustomerTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    c = Customer.new({id: 1, first_name: "Joey", last_name: "Ondricka", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC"}, se)

    assert_instance_of Customer, c
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

    c = Customer.new({id: 1, first_name: "Joey", last_name: "Ondricka", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC"}, se)

    assert_equal 1, c.id
    assert_equal "Joey", c.first_name
    assert_equal "Ondricka", c.last_name
    assert_instance_of Time, c.created_at
    assert_equal "2012-03-27 14:54:09 UTC", c.created_at.to_s
    assert_instance_of Time, c.updated_at
    assert_equal "2012-03-27 14:54:09 UTC", c.updated_at.to_s
  end

  def test_invoice_returns_invoices_of_customer
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    c = Customer.new({id: 1, first_name: "Joey", last_name: "Ondricka", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC"}, se)

    assert_instance_of Array, c.invoices
    assert_equal 8, c.invoices.count
    c.invoices.each do |invoice|
      assert_instance_of Invoice, invoice
      assert_equal 1, invoice.customer_id
    end
  end

  def test_merchants_returns_merchants_of_customer
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    c = Customer.new({id: 1, first_name: "Joey", last_name: "Ondricka", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC"}, se)

    assert_instance_of Array, c.merchants
    assert_equal 8, c.merchants.count
  end
end
