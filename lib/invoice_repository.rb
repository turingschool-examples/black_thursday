require_relative './invoice'

class InvoiceRepository
  attr_reader :invoices
  
  def initialize(invoices)
    @invoices = []
    invoices.each {|invoice| @invoices << Invoice.new(to_invoice(invoice))}
  end

  def to_invoice(invoice)
    invoice_hash = {}
    invoices.each do |line|
      invoice_hash[line[0]] = line[1]
    end
    invoice_hash
  end



  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

end
