require 'CSV'
require "BigDecimal"
require_relative'./invoice.rb'

class InvoiceRepository
  def initialize(invoice_path)
    @invoice_path = invoice_path
  end
end
