require_relative './invoice_helper.rb'
require_relative './invoice_item_helper.rb'
require_relative './customer_helper.rb'

module RepositoryHelper
  include InvoiceHelper
  include InvoiceItemHelper
  include CustomerHelper
end 