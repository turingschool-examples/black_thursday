require 'csv'
require './lib/invoice_item'

class InvoiceItemRepository

  def initialize(invoice_files, parent)
    @invoices      = []
    @parent        = parent
  end



end
