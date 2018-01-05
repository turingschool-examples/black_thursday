require 'csv'
require './lib/transaction'

class TransactionRepository
  def initialize(file_path)
    @transactions = []
    transaction_data = CSV.open file_path, headers: true, header_converters: :symbol, converters: :numeric
    parse(transaction_data)
  end

  def self.from_csv(file_path)
    new(file_path)
  end

  def parse(transaction_data)
    transaction_data.each do |row|
      @transactions << Transaction.new(row.to_hash)
    end
  end

  def all
    return @transactions
  end

  def find_by_id(id)
    @transactions.find do |transaction|
      transaction.id == id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @transactions.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
  end
end
