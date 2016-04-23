require_relative 'transaction'

class TransactionRepository
  attr_reader :transactions

  def initialize(transactions_data)
    @transactions = create_transactions(transactions_data)
  end

  def create_transactions(transactions_data)
    transactions_data.map do |trans|
      Transaction.new(trans)
    end
  end

  def all
    transactions
  end

  def find_by_id(transaction_id)
    transactions.find do |transaction|
      transaction.id == transaction_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    transactions.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def find_all_by_credit_card_number(credit_card_number)
    transactions.find_all do |transaction|
      transaction.credit_card_number == credit_card_number
      # require 'pry' ; binding.pry
    end
  end

  def find_all_by_result(result)
    transactions.find_all do |transaction|
      transaction.result == result
    end
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end

end
