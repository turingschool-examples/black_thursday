sa.top_buyers(x) #=> [customer, customer, customer, customer, customer]

sa.top_buyers #=> [customer * 20]

sa.top_merchant_for_customer(customer_id) #=> merchant

sa.one_time_buyers #=> [customer, customer, customer]

sa.one_time_buyers_item #=> [item]

sa.items_bought_in_year(customer_id, year) #=> [item]

sa.highest_volume_items(customer_id) #=> [item] or [item, item, item]

sa.customers_with_unpaid_invoices #=> [customer, customer, customer]


require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_analyst'

class CustomerAnalyticsTest < Minitest::Test

  def test_include
