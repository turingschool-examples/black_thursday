require_relative "transaction"
require_relative "sales_engine"
require "csv"

class TransactionRepo
  attr_reader :transactions,
              :sales_engine

  def initialize(sales_engine, filename)
    @transactions = []
    @sales_engine = sales_engine
    load_transactions(filename)
  end

  def load_transactions(filename)
    transaction_csv = CSV.open filename,
                                headers: true,
                                header_converters: :symbol
    transaction_csv.each do |row| @transactions << Transaction.new(row, self)
    end
  end

  def all
    transactions
  end

  def find_by_id(id)
    transactions.find { |transaction| transaction.id == id }
  end

  def find_all_by_invoice_id(invoice_id)
    transactions.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def find_all_by_credit_card_number(credit_card_number)
    transactions.find_all do |transaction|
      transaction.credit_card_number == credit_card_number
    end
  end

  def find_all_by_result(result)
    transactions.find_all { |transaction| transaction.result == result }
  end
end
