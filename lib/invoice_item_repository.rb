require 'bigdecimal'
require 'bigdecimal/util'
require_relative 'repository'

class InvoiceItemRepository
  include Repository

  def initialize(invoice_items)
    @list = invoice_items
  end
end
