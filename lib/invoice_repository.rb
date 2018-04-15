require_relative './invoice'

class InvoiceRepository

  def initialize(invoices)
    @invoices = []
    invoices.each {|invoice| @invoices << Invoice.new(to_invoice(invoice))}
  end

  # def update(id, attributes)

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

end
