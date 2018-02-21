require 'pry'
require 'csv'
require_relative 'transaction'

# This is an transaction repository class
class TransactionRepository
  attr_reader :parent, :transactions

  def initialize(transaction_csv, parent)
    @parent = parent
    @transactions = []

    csv_file = CSV.open(transaction_csv, headers: true, header_converters: :symbol)
    csv_file.each do |row|
      @transactions << Transaction.new(row, self)
    end
  end

  def all
    @transactions
  end

  def find_by_id(id)
    @transactions.find { |transaction| transaction.id == id }
  end

  def find_all_by_invoice_id(invoice_id)
    @transactions.find_all { |transaction| transaction.invoice_id == invoice_id }
  end

  def find_all_by_credit_card_number(cc_num)
    @transactions.find_all { |transaction| transaction.credit_card_number == cc_num }
  end
# find_all_by_result - returns either [] or one or more matches which have a matching status
end
