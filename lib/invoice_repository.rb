require 'bigdecimal'
require 'bigdecimal/util'
require 'time'

class InvoiceRepository
  def initialize(invoices)
    @invoices = invoices
  end

end
