require_relative 'transaction'
require_relative "sales_engine"
require_relative 'find'
require_relative "csv_io"
require "pry"

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

  def find_all_by_credit_card_number(credit_card_number)
    find_all_by_num({:credit_card_number => credit_card_number})
  end

  def find_all_by_result(result)
    find_all_by_string_full({:result => result})
  end

end
