require_relative 'transaction'

class TransactionRepository
  attr_reader :transactions, :sales_engine

  def initialize(transactions_file, sales_engine)
    @transactions = read_transactions_file(transactions_file)
    @sales_engine = sales_engine
  end

  def read_transactions_file(transactions_file)
    transactions_list  = []
    CSV.foreach(transactions_file, headers: true, header_converters: :symbol) do |row|
      transaction_info = {}
      transaction_info[:id] = row[:id]
      transaction_info[:invoice_id] = row[:invoice_id]
      transaction_info[:credit_card_number] = row[:credit_card_number]
      transaction_info[:credit_card_expiration_date]=row[:credit_card_expiration_date]
      transaction_info[:result] = row[:result]
      transaction_info[:created_at] =row[:created_at]
      transaction_info[:updated_at] = row[:updated_at]
      transactions_list << Transaction.new(transaction_info, self)
    end
    transactions_list
  end

  def all
    transactions
  end

  def find_by_id(id)
    transactions.find { |transaction| transaction.id == id }
  end

  def find_all_by_invoice_id(invoice_id)
    transactions.find_all {|transaction| transaction.invoice_id == invoice_id}
  end

  def find_all_by_credit_card_number(credit_card_number)
    transactions.find_all do |transaction|
      transaction.credit_card_number == credit_card_number
    end
  end

  def find_all_by_result(result)
    transactions.find_all {|transaction| transaction.result == result}
  end

  def transaction_invoice(invoice_id)
    sales_engine.find_invoice_for_transaction(invoice_id)
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end
end
