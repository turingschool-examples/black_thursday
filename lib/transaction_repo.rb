require 'CSV'
require_relative './transaction'
class TransactionRepository
  attr_reader :engine, :file
  attr_accessor :transactions

  def initialize(file = './data/transactions.csv', engine)
    @engine = engine
    @file = file
    @transactions = {}
    make_transactions(CSV.readlines(@file, headers: true, header_converters: :symbol))
  end

  def make_transactions(data)
    data.each do |row|
      transactions[row[:id].to_i] = Transaction.new({id: row[:id].to_i,
                                                    invoice_id: row[:invoice_id].to_i,
                                                    credit_card_number: row[:credit_card_number],
                                                    credit_card_expiration_date: row[:credit_card_expiration_date],
                                                    result: row[:result].to_sym,
                                                    created_at: row[:created_at],
                                                    updated_at: row[:updated_at].to_i})
    end
  end

  def all
    transactions.values
  end

  def find_by_id(id)
    transactions[id]
  end

  def find_all_by_invoice_id(invoice)
    all.find_all do |transaction|
      invoice == transaction.invoice_id
    end
  end
end