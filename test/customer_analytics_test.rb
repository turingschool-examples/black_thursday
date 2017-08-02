require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_analyst'

class CustomerAnalyticsTest < Minitest::Test

  def test_top_buyers_default
    skip
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    top = sales_analyst.top_buyers

    assert_instance_of Array, top
    assert top.all? {|buyer| buyer.is_a?(Customer)}
    assert_equal 20, top.length
  end

  def test_top_buyers_arguement
    skip
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    top = sales_analyst.top_buyers(5)

    assert_instance_of Array, top
    assert top.all? {|buyer| buyer.is_a?(Customer)}
    assert_equal 5, top.length
  end

  def test_top_merchant_for_customer
    skip
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    top = sales_analyst.top_merchant_for_customer(5)

    assert_instance_of Merchant, top
  end

  def test_one_time_buyers
    skip
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    buyers = sales_analyst.one_time_buyers

    assert_instance_of Array, buyers
    assert buyers.all? {|buyer| buyer.is_a?(Customer)}
  end

  def test_one_time_buyers_item
    skip
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    item = sales_analyst.one_time_buyers_item

    assert_instance_of Item, item
  end

  def test_items_bought_in_year
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    bought_in_year = sales_analyst.items_bought_in_year(1, 2009)

    assert_equal 8, bought_in_year.length
    assert bought_in_year.all? {|item| item.is_a?(Item)}
  end

  def test_highest_volume_items
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    highest_items = sales_analyst.highest_volume_items(2)

    assert_instance_of Array, highest_items
    refute_nil highest_items[0]
  end

  def test_customers_with_unpaid_invoices
    skip
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
    })
    sales_analyst = SalesAnalyst.new(sales_engine)

    unpaid_customers = sales_analyst.customers_with_unpaid_invoices

    assert_instance_of Array, unpaid_customers
    assert unpaid_customers.all? {|customer| customer.is_a?(Customer)}
    assert_equal 786, unpaid_customers.length
  end

end
