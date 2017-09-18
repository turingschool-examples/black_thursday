require 'csv'
require_relative 'transaction'
class TransactionRepo

  attr_reader :all_transactions, :parent

  def initialize(file, se=nil)
    @all_transactions = []
    open_file(file)
    @parent = se
  end

  def open_file(file)
    CSV.foreach file,  headers: true, header_converters: :symbol do |row|
      all_transactions << Transaction.new(row, self)
    end
  end
  def all
    @all_transactions
  end

  def find_by_id(trans_id)
    all_transactions.find {|transaction| transaction.id == trans_id }
  end

  def find_all_by_invoice_id(invoice_id)
    all_transactions.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
  end
  def find_all_by_credit_card_number(cred_card)
    all_transactions.find_all do |transaction|
      transaction.credit_card_number == cred_card
    end
  end

  def find_all_by_result(res)
    all_transactions.find_all do |transaction|
      transaction.result == res
    end
  end
end
