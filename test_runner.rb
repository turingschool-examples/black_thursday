require 'simplecov'
SimpleCov.start do
  add_filter 'test/'
end

require './test/customer_repository_test.rb'
require './test/customer_test.rb'
require './test/invoice_item_repository_test.rb'
require './test/invoice_repository_test.rb'
require './test/invoice_test.rb'
require './test/item_repository_test.rb'
require './test/item_test.rb'
require './test/merchant_repository_test.rb'
require './test/merchant_test.rb'
require './test/sales_analyst_test.rb'
require './test/sales_engine_test.rb'
