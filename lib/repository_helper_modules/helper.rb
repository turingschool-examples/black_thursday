require_relative './invoice_helper.rb'
require_relative './invoice_item_helper.rb'

module Helper
  include InvoiceHelper
  include InvoiceItemHelper
end 