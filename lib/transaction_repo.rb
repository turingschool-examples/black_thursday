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
    "#<#{self.class} #{@merchants.size} rows>"
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
    array_of_matching_ccs = []
    all.find_all do |transaction|
        if transaction.credit_card_number = credit_card_number
          array_of_matching_ccs << transaction
        end
    end
  end

  def find_all_by_result(result)
    array_of_matching_results = []
    all.find_all do |transaction|
      if transaction.result == result.to_sym
        array_of_matching_results << transaction
      end
    end
  end

end
