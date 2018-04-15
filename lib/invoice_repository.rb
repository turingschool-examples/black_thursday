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

  def all
    @invoices
  end


  def find_by_id(input_id)
    @invoices.find do |invoice|
      invoice.id == input_id
    end
  end

  def find_all_by_customer_id(input_id)
    @invoices.find_all do |invoice|
      invoice.customer_id == input_id
    end
  end

  def find_all_by_merchant_id(input_id)
    @invoices.find_all do |invoice|
      invoice.merchant_id == input_id
    end
  end

end
