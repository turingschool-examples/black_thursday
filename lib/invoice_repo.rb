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
      data = row.to_h
      invoices[data[:id].to_i] = Invoice.new(data, self)
    end
  end

  def all
    invoices.values
  end

  def find_by_id(id)
    invoices[id]
  end

  def find_all_by_customer_id(cust_id)
    all.find_all do |invoice|
      invoice.customer_id == cust_id
    end
  end

end
