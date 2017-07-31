require_relative 'transaction'
require 'csv'
require 'pry'

class TransactionRepository
  attr_reader :transactions, :engine

  def initialize(csvfile, engine)
    @engine       = engine
    @transactions = create_hash_of_transactions(csvfile)
  end

  def create_hash_of_transactions(csvfile)
    all_transactions = {}
    csvfile.each do |row|
      all_transactions[row[:id]] = Transaction.new(row, self)
    end
    all_transactions
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end

  def all
    @transactions.values
  end

  def find_by_id(id)
    @transactions[id.to_s]
  end

  def find_all_by_invoice_id(invoice_id)
    array_of_matching_transactions = []
    all.find_all do |transaction|
      if transaction.invoice_id == invoice_id
        array_of_matching_transactions << transaction
      end
    end
  end

  def find_all_by_credit_card_number(credit_card_number)
    array_of_matching_credit_cards = []
    all.find_all do |transaction|
        if transaction.credit_card_number == credit_card_number
          array_of_matching_credit_cards << transaction
        end
    end
  end

  def find_all_by_result(result)
    array_of_matching_results = []
    all.find_all do |transaction|
      if transaction.result == result
        array_of_matching_results << transaction
      end
    end
  end

  def find_invoices_by_transaction(invoice_id)
    @engine.find_invoices_by_transaction(invoice_id)
  end
end
