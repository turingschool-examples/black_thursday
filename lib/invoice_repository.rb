require_relative 'invoice'

class InvoiceRepository
  def initialize
    @type = Invoice
    @attr_whitelist = [:status]
    super
  end
end
