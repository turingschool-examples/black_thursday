require_relative 'transaction'
require_relative 'find'
require_relative 'csv_io'

class TransactionRepository
  include Find
  include CSV_IO

  attr_accessor :transactions
  attr_reader :file, :sales_engine

  def initialize(file=nil, sales_engine)
    @file = file
    @transactions = []
    @sales_engine = sales_engine
  end

  def add_new(data, sales_engine)
    transactions << Transaction.new(data, sales_engine)
  end

  def all
    @transactions
  end

  def find_by_id(id)
    find_by_num({:id => id})
  end

  def find_all_by_invoice_id(invoice_id)
    find_all_by_num({:invoice_id => invoice_id})
  end
end
