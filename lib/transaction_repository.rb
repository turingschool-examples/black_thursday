require_relative 'transaction'

class TransactionRepository
  attr_reader :transactions, :parent

  def initialize(transaction_contents, parent = nil)
    @transactions = make_transactions(transaction_contents)
    @parent = parent
  end

  def make_transactions(transaction_contents)
    transaction_contents.map { |row| Transaction.new(row, self) }
  end

  def all
    @transactions
  end

  def find_by_id(id)
    @transactions.find { |transaction| transaction.id == id }
  end

  def find_all_by_invoice_id(invoice_id)
    @transactions.find_all { |txn| txn.invoice_id == invoice_id }
  end

  def find_all_by_credit_card_number(cc_number)
    @transactions.find_all { |txn| txn.credit_card_number == cc_number }
  end

  def find_all_by_result(result)
    @transactions.find_all do |transaction|
      transaction.result == result
    end
  end

  def find_invoice_by_id(invoice_id)
    @parent.find_invoice_by_id(invoice_id)
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end
end
