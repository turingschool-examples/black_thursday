require_relative '../lib/sales_engine'
require 'bigdecimal'
require 'time'
require_relative '../lib/customer'
require 'csv'
require 'minitest/autorun'
require 'minitest/emoji'

class CustomerTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
              :items => "./test/data/items_fixture.csv",
              :merchants => "./test/data/merchants_fixture.csv",
              :invoice_items => "./test/data/invoice_items_fixture.csv",
              :invoices => "./test/data/invoices_fixture.csv",
              :transactions => "./test/data/transactions_fixture.csv",
              :customers => "./test/data/customers_fixture.csv"
            })
    @c = Customer.new({
              :id => 6,
              :invoice_id => 8,
              :credit_card_number => "4242424242424242",
              :credit_card_expiration_date => "0220",
              :result => "success",
              :created_at => Time.now,
              :updated_at => Time.now
            }, @se.customers)
    end
