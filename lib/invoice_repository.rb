require_relative 'invoice'
require_relative 'csv_io'
require_relative 'find'

class InvoiceRepository
  include Find
  include CSV_IO

  attr_accessor :invoices
  attr_reader :file, :sales_engine

  def initialize(file=nil, sales_engine)
    @file = file
    @invoices = []
    @sales_engine = sales_engine
  end

  def add_new(data, sales_engine)
    invoices << Invoice.new(data, sales_engine)
  end

  def all
    @invoices
  end


end
