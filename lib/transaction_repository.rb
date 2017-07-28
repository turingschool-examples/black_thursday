require 'pry'
require 'csv'
require 'time'
require_relative '../lib/transaction'
require_relative '../lib/file_opener'

class TransactionRepository
  include FileOpener
  attr_reader :all

  def initialize(transactions, sales_engine)
    @transactions = open_csv(transactions)
    @se = sales_engine
    @all = @transactions.map do |row|
      Transaction.new(row, self)
    end
  end



  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def find_by_id(id)
    @all.find do |transaction|
      transaction.id == id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @all.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def find_all_by_credit_card_number(cc_num)
    @all.find_all do |transaction|
      transaction.credit_card_number == cc_num
    end
  end

  def find_all_by_result(result)
    @all.find_all do |transaction|
      transaction.result == result
    end
  end

end
