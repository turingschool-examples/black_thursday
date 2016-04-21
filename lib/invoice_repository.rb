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

  def find_by_id(id)
    find_by_num({:id => id})
  end

  def find_all_by_customer_id(customer_id)
    find_all_by_num({:customer_id => customer_id})
  end

  def find_all_by_merchant_id(merchant_id)
    find_all_by_num({:merchant_id => merchant_id})
  end

  def find_all_by_status(status)
    find_all_by_string_full({:status => status})
  end


end
