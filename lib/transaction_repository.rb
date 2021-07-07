require 'csv'
require_relative 'transaction'

# This is an transaction repository class
class TransactionRepository
  attr_reader :parent, :transactions

  def initialize(trans_csv, parent)
    @parent = parent
    @transactions = []

    csv_file = CSV.open(trans_csv, headers: true, header_converters: :symbol)
    csv_file.each do |row|
      @transactions << Transaction.new(row, self)
    end
  end

  def all
    @transactions
  end

  def find_by_id(id)
    @transactions.find do |transaction|
      transaction.id == id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @transactions.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def find_all_by_credit_card_number(cc_num)
    @transactions.find_all do |transaction|
      transaction.credit_card_number == cc_num
    end
  end

  def find_all_by_result(result)
    @transactions.find_all do |transaction|
      transaction.result == result
    end
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end
end
