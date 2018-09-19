require 'pry'

require_relative 'finderclass'
require_relative 'crud'

require_relative 'transaction'


class TransactionRepository
  include CRUD

  attr_reader :all

  def initialize(data)
    @data = data
    @transactions = []
    make_transactions
    @all = @transactions
  end

  def make_transactions(data = @data)
    data.each { |key, value|
      hash = make_hash(key, value)
      transaction = Transaction.new(hash)
      @transactions << transaction
    }
  end

  def make_hash(key, value)
    hash = {id: key.to_s.to_i}
    value.each { |col, data| hash[col] = data }
    return hash
  end


  # --- Spec Harness Requirement ---

  # TO DO - TEST ME
  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end


  # --- Find By ---

  def find_by_id(id)
    FinderClass.find_by(all, :id, id)
  end

  def find_all_by_invoice_id(invoice_id)
    FinderClass.find_all_by(all, :invoice_id, invoice_id)
  end

  def find_all_by_credit_card_number(credit_card_number)
    FinderClass.find_all_by(all, :credit_card_number, credit_card_number)
  end

  def find_all_by_result(result)
    FinderClass.find_all_by(all, :result, result)
  end


  # --- CRUD ---

  def create(hash)
    last = FinderClass.find_max(all, :id)
    new_id = last.id + 1
    hash[:id] = new_id
    transaction = Transaction.new(hash)
    @transactions << transaction
    return transaction
  end

  def update(id, attributes)
    transaction = find_by_id(id)
    transaction.make_updates(attributes) if transaction
  end

  def delete(id)
    @transactions.delete_if{ |transaction| transaction.id == id }
  end

end
