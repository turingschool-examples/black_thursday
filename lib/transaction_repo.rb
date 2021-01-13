require 'CSV'
require 'Time'
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

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end

  def make_transactions(data)
    data.each do |row|
      transactions[row[:id].to_i] = Transaction.new({id: row[:id].to_i,
                                                    invoice_id: row[:invoice_id].to_i,
                                                    credit_card_number: row[:credit_card_number],
                                                    credit_card_expiration_date: row[:credit_card_expiration_date],
                                                    result: row[:result].to_sym,
                                                    created_at: Time.parse(row[:created_at]),
                                                    updated_at: Time.parse(row[:updated_at])})
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

  def find_all_by_credit_card_number(num)
    all.find_all do |transaction|
      num.to_s == transaction.credit_card_number
    end
  end

  def find_all_by_result(result)
    all.find_all do |transaction|
      result == transaction.result
    end
  end

  def max_id
    transactions.keys.max
  end

  def create(attributes)
    new = Transaction.new(attributes)
    new.id = (max_id + 1)
    transactions[new.id] = new
  end

  def update(id, attributes)
    if find_by_id(id) != nil
      transactions[id].update(attributes)
    end
  end

  def delete(id)
    transactions.delete(id)
  end

  def successful_transactions
    find_all_by_result(:success)
  end

  def successful_transactions_invoice_ids
    successful_transactions.map do |successful_transaction|
      successful_transaction.invoice_id
    end.flatten.uniq
  end
end
