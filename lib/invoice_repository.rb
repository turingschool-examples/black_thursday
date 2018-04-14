require_relative 'invoice'
require 'time'
require 'pry'

class InvoiceRepository
  attr_reader :invoices

  def initialize(invoices)
    @invoices = []
    invoices.each {|invoice| @invoices << Invoice.new(to_invoice(invoice))}
  end

  def to_invoice(invoice)
    invoice_hash = {}
    invoice.each do |line|
      invoice_hash[line[0]] = line[1]
    end
    invoice_hash
  end



  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

end
