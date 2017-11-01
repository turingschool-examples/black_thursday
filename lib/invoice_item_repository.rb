require 'csv'
require './lib/invoice_item'

class InvoiceItemRepository

  def initialize(invoice_files, parent)
    @invoices      = []
    @invoice_files = invoice_files
    @parent        = parent
  end



end
