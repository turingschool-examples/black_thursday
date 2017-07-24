require 'csv'
require_relative 'invoice'

class InvoiceRepo
  attr_reader :invoices

  def initialize(filename, se=nil)
    @invoices = {}
    open_file(filename)
  end

  def open_file(filename)
    CSV.foreach filename,  headers: true, header_converters: :symbol do |row|
      stuff = row.to_h
      invoices[stuff] = Invoice.new(stuff, self)
    end
  end

  def all
    invoices.keys
  end
end
