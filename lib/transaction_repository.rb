require 'csv'
require_relative '../lib/transaction'
require_relative '../lib/file_opener'

class TransactionRepository
  include FileOpener
  attr_reader :sales_engine,
              :all_transactions

  # def inspect
  #   "#<#{self.class} #{@items.size} rows>"
  # end

  def initialize(data_files, sales_engine)
    @sales_engine = sales_engine
    all_transactions = open_csv(data_files)
    @all_transactions = all_transactions.map{|row| Transaction.new(row, self)}
  end

  def all
    @all_transactions
  end

  

end
