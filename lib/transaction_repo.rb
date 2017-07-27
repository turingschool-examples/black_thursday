require_relative 'transaction'


class TransactionRepository
  attr_reader :transactions, :engine

  def initialize(csv_data, engine)
    @engine       = engine
    @transactions = csv_data
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def all
    transactions
  end

  def find_by_id(id)
    transactions.detect { |transaction| transaction.id == id }
  end

  def find_all_by_invoice_id(invoice_id)
    transactions.select { |transaction| transaction.invoice_id == invoice_id } || []
  end

  def find_all_by_credit_card_number(credit_card_number)
    transactions.select { |transaction| transaction.credit_card_number == credit_card_number } || []
  end

  def find_all_by_result(status)
    transactions.select { |transaction| transaction.status == status } || []
  end

end
