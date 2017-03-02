require_relative 'transaction'
require 'pry'
class TransactionRepository

  attr_reader :transactions, :sales_engine

  def initialize (transactions, sales_engine = nil)
    @transactions = transactions
    @sales_engine = sales_engine
  end

  def all
    transactions
  end

  def find_by_id(id)
    transactions.find { |row| row.id == id }
  end

  def find_all_by_invoice_id(invoice_id)
     transactions.select { |row| row.invoice_id == invoice_id }
  end

  def find_all_by_credit_card_number(credit_card_number)
     transactions.select { |row| row.credit_card_number == credit_card_number }
  end

  def find_all_by_result(result)
     transactions.select { |row| row.result == result }
  end

  def inspect
  "#<#{self.class} #{@merchants.size} rows>"
  end
end
