class TransactionRepository
  attr_reader :transactions,
              :parent

  def initialize(transactions, parent)
    @transactions = transactions.map {|transaction|
      Transaction.new(transaction, self)}
    @parent = parent
  end

  def all
    transactions
  end

  def find_by_id(id)
    transactions.find do |transaction|
      transaction.id == id
    end
  end

  def find_all_by_invoice_id(id)
    transactions.find_all do |transaction|
      transaction.invoice_id == id
    end
  end

  def find_all_by_credit_card_number(number)
    transactions.find_all do |transaction|
      transaction.credit_card_number == number
    end
  end

  def find_all_by_result(result)
    transactions.find_all do |transaction|
      transaction.result.downcase == result.downcase
    end
  end
end
