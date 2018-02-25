require 'csv'
require_relative 'transaction'
require 'pry'

class TransactionRepository

  attr_reader :engine

  def initialize(filepath, parent = nil)
    @transactions    = []
    @engine           = parent
    load_items(filepath)
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end

  def all
    @transactions
  end

  def load_items(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
      @transactions << Transaction.new(data, self)
    end
  end

  def find_by_id(id)
    @transactions.find { |transaction| transaction.id == id }
  end

  def find_all_by_invoice_id(id)
    @transactions.find_all { |transaction| transaction.invoice_id == id }
  end

  def find_all_by_credit_card_number(number)
    @transactions.find_all do |transaction|
      transaction.credit_card_number == number
    end
  end

  def find_all_by_result(result)
    @transactions.find_all { |transaction| transaction.result == result.to_s }
  end

  def find_invoice_by_invoice_id(invoice_id)
    engine.find_invoice_by_invoice_id(invoice_id)
  end

end
