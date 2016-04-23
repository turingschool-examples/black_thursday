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
  end

  def find_by_id(transaction_id)
  end

  def find_all_by_invoice_id(invoice_id)
  end

  def find_all_by_credit_card_number(credit_card_number)
  end

  def find_all_by_result
  end

end
