require_relative './data_parser'
require 'bigdecimal'

class InvoiceItem
    include DataParser
  def initialize(invoice_item_data, parent = nil)
    @parent = parent
  end
end
