require_relative 'transaction'

class TransactionRepository
  attr_reader :transactions

  def initialize(transactions_data)
    @transactions = create_transactions(transactions_data)
  end

  def create_transactions(transactions_data)
    transactions_data.map { |transaction| Transaction.new(transaction) }
  end

  def all
    transactions
  end

  def find_by_id(transaction_id)
    transactions.find { |transaction| transaction.id == transaction_id }
  end

  def find_all_by_invoice_id(invoice_id)
    transactions.find_all { |transaction| transaction.invoice_id == invoice_id }
  end

  def find_all_by_credit_card_number(credit_card_number)
    transactions.find_all do |transaction|
      transaction.credit_card_number == credit_card_number
    end
  end

  def find_all_by_result(result)
    transactions.find_all { |transaction| transaction.result == result }
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end

end
