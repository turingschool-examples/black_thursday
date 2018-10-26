require_relative './repository'

class InvoiceRepository < Repository

  def initialize
    @collection = {}
  end

  def add_invoice(invoice)
    @collection[invoice.id] = invoice
  end

end
