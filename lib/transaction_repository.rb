require_relative "transaction"
require "csv"

class TransactionRepository
  attr_reader :transactions

  def initialize(transactions_file)
    @transactions = []
    items_from_csv(transactions_file)
  end

  def items_from_csv(transactions_file)
    CSV.foreach(transactions_file, headers: true, header_converters: :symbol) do |row|
      @transactions << Transaction.new(row)
    end
  end

  def all
    @transactions
  end

  def find_by_id(id)
    @transactions.find {|transaction| transaction.id == id}
  end

  def find_all_by_invoice_id(invoice_id)
    @transactions.find_all {|transaction| transaction.invoice_id == invoice_id}
  end

  def find_all_by_credit_card_number(credit_card_number)
    @transactions.find_all {|transaction| transaction.credit_card_number == credit_card_number}
  end

  def find_all_by_result(result)
    @transactions.find_all {|transaction| transaction.result == result}
  end
end
