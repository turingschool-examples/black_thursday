# sa.top_buyers(x) #=> [customer, customer, customer, customer, customer]
#
# sa.top_buyers #=> [customer * 20]
#
# sa.top_merchant_for_customer(customer_id) #=> merchant
#
# sa.one_time_buyers #=> [customer, customer, customer]
#
# sa.one_time_buyers_item #=> [item]
#
# sa.items_bought_in_year(customer_id, year) #=> [item]
#
# sa.highest_volume_items(customer_id) #=> [item] or [item, item, item]
#
# sa.customers_with_unpaid_invoices #=> [customer, customer, customer]


require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_analyst'

class CustomerAnalyticsTest < Minitest::Test

  def test_top_buyers_default
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
  



end
