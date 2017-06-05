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

  def find_by_id(id)
    @all_transactions.find{|transaction| transaction.id == id}
  end

  def find_all_by_invoice_id(id)
    @all_transactions.find_all{|trans| trans.invoice_id == id}
  end

  def find_all_by_credit_card_number(cc_num)
    @all_transactions.find_all{|trans| trans.credit_card_number == cc_num}
  end

  def find_all_by_result(result)
    @all_transactions.find_all{|trans| trans.result == result}
  end

end
