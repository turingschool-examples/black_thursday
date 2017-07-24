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
      invoices[stuff[:id].to_i] = Invoice.new(stuff, self)
    end
  end

  def all
    invoices.values
  end

  def find_by_id(id)
    invoices[id]
  end
  
end
