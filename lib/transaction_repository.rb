require_relative 'transaction'
require 'time'
require "csv"

class TransactionRepository
  attr_reader :filename,
              :parent,
              :transactions

  def initialize(filename, parent)
    @filename = filename
    @parent = parent
    @transactions = Array.new
    generate_transactions(filename)
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end

  def generate_transactions(filename)
    transactions = CSV.open filename, headers: true, header_converters: :symbol
    transactions.each do |row|
      @transactions << Transaction.new(row, self)
    end
  end

  def all
    @transactions
  end

  def find_by_id(id)
    @transactions.find do |transaction|
      transaction.id.to_i == id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @transactions.find_all do |transaction|
     transaction.first_name.downcase.include?(invoice_id.downcase)
    end
  end

  def find_all_by_credit_card_number(credit_card_number)
    @transactions.find_all do |transaction|
     transaction.last_name.downcase.include?(credit_card_number.downcase)
   end
  end

  def find_all_by_result(result)
    @transactions.find_all do |transaction|
     transaction.last_name.downcase.include?(result.downcase)
    end
  end

  def create(attributes)
    id = @transactions[-1].id.to_i
    id += 1
    id = id.to_i
    attributes[:id] = id
    transaction = Transaction.new(attributes, self)
    @transactions << transaction
  end

  def update(id, attributes)
    update_transaction = find_by_id(id)
    update_transaction.update(attributes) if !attributes[:credit_card_number].nil?
    update_transaction.update(attributes) if !attributes[:credit_card_expiration_date].nil?
    update_transaction.update(attributes) if !attributes[:result].nil?
    update_tran
  end

  def delete(id)
    delete = find_by_id(id)
    @transactions.delete(delete)
  end
end
