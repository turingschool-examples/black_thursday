require 'simplecov'

SimpleCov.start do
  add_filter '/spec/'
end

require 'pry'

# require './merchant_spec'
# require './item_repository_spec'
# require './item_spec'
# require './merchant_repository_spec'
# require './sales_engine_spec'
# require './invoice_spec'
# require './invoice_repository_spec'
# require './sales_analyst_spec'
require './lib/item'
require './lib/merchant'
require './lib/item_repository'
require './lib/merchant_repository'
require './lib/sales_analyst'
require './lib/invoice'
require './lib/invoice_repository'
