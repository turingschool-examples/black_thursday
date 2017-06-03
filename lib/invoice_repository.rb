require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice'
require 'pry'

class InvoiceRepository

  def initialize(file, sales_engine)
    @sales_engine = sales_engine
    @all = []
  end

  def populate_invoice_repo(file)
    invoice_lines = CSV.open(file, headers: true, header_converters: :symbol)
    invoice_lines.each do |row|
      invoice = Invoice.new(row, self)
      all << invoice
    end
    invoice_lines.close
  end

end
