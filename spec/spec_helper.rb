require 'rspec'
require 'simplecov'
require 'csv'

SimpleCov.start do
end

require 'bigdecimal'
require './lib/item'
require './lib/item_repository'
require './lib/merchant'
require './lib/sales_engine'
require './lib/merchant_repository'
require './lib/sales_analyst'
require './lib/invoice'
require './lib/invoice_repository'
require './lib/invoice_item'
require './lib/invoice_item_repository'
require './lib/customer'
require './lib/customer_repository'
require './lib/math_module'
require './lib/transaction'
require './lib/transaction_repository'
