require 'csv'
require 'simplecov'
require './lib/sales_engine'
require './lib/customer_repo'
require './lib/customer'
SimpleCov.start

RSpec.describe do
  before(:each) do
    @engine = SalesEngine.from_csv({
                                     items: './data/items.csv',
                                     merchants: './data/merchants.csv',
                                     invoices: "./data/invoices.csv",
                                     invoice_items: './data/invoice_items.csv',
                                     customers: './data/customers.csv'
                                   })
  end

end
