require 'CSV'
require_relative './cleaner.rb'
require_relative './invoice.rb'

class InvoiceRepository
  attr_reader :invoices

  def initialize(file = './data/invoices.csv')
    @file = file
    @invoices = []
    @data = CSV.open(@file, headers: true, header_converters: :symbol)
  end

end
