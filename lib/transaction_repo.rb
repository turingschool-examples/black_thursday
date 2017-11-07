require_relative "transaction"
require_relative "sales_engine"
require 'csv'
require 'pry'

class TransactionRepository
  attr_reader :transactions,
              :sales_engine

  def initialize(parent, filename)
    @transactions       = []
    @sales_engine        = parent
    @load                = load_file(filename)
  end

  def load_file(filename)
    transactions_csv = CSV.open filename,
                             headers: true,
                             header_converters: :symbol
    transactions_csv.each do |transaction| @transactions << Transaction.new(transaction, self) end
  end

  def all
    transactions
  end

  def find_by_id(id)
    transactions.find { |transaction| transaction.id == id.to_i }
  end

  def find_all_by_invoice_id(invoice_id)
    transactions.find_all { |transaction| transaction.invoice_id == invoice_id.to_i }
  end

  def find_all_by_credit_card_number(credit_card_number)
    transactions.find_all { |transaction| transaction.credit_card_number == credit_card_number }
  end

  def find_all_by_result(result)
    transactions.find_all { |transaction| transaction.result == result }
  end

  def inspect
      "#<#{self.class} #{@transactions.size} rows>"
  end

  def find_invoice_by_invoice_id(id)
    sales_engine.find_invoice_by_invoice_id(id)
  end

end
