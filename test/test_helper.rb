require 'simplecov'
SimpleCov.start do
  add_filter "test"
end
require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
require 'pry'
require './lib/sales_engine'

module Setup
    @se = SalesEngine.from_csv({
      :items => "./fixtures/items_small_list.csv",
      :invoices => "./fixtures/invoices_small_list.csv",
      :merchants => "./fixtures/merchant_small_list.csv",
      :customers => "./fixtures/invoices_small_list.csv",
      :invoice_items => "./fixtures/invoice_item_small_list.csv",
      :transactions => "./fixtures/transactions_small_list.csv",
      :customers => "./fixtures/customers_small_list.csv"
    })
end