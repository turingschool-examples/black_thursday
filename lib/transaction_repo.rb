require_relative './transaction'
require 'time'
require 'csv'
require 'bigdecimal'

class TransactionRepo
  attr_reader :transaction_list

  def initialize(csv_files, engine)
    @transaction_list = transaction_instances(csv_files)
    @engine = engine
  end

  def transaction_instances(csv_files)
    transactions = CSV.open(csv_files, headers: true, header_converters: :symbol)

    @transaction_list = transactions.map do |transaction|
      Transaction.new(transaction, self)
    end
  end

  def all
    @transaction_list
  end

  def find_by_id(id)
    @transaction_list.find do |transaction|
      transaction.id == id
    end
  end

  def find_all_by_invoice_id(id)
    @transaction_list.find_all do |transaction|
      transaction.invoice_id == id
    end
  end

  def find_all_by_credit_card_number(number)
    @transaction_list.find_all do |transaction|
      transaction.credit_card_number == number
    end
  end

  def find_all_by_result(status)
    @transaction_list.find_all do |transaction|
      transaction.result == status
    end
  end

  def create(attributes)
    new_transaction = Transaction.new(attributes, self)
    find_max_id = @transaction_list.max_by do |transaction|
      transaction.id
    end
    new_transaction.id = (find_max_id.id + 1)
    transaction_list << new_transaction
  end

  def update(id, attributes)
    transaction = find_by_id(id)
    if !transaction.nil?
      transaction.credit_card_number = attributes[:credit_card_number] unless attributes[:credit_card_number].nil?
      transaction.credit_card_expiration_date = attributes[:credit_card_expiration_date] unless attributes[:credit_card_expiration_date].nil?
      transaction.result = attributes[:result] unless attributes[:result].nil?
      transaction.updated_at = Time.now
    end
    transaction
  end

  def delete(id)
    transaction = find_by_id(id)
    if transaction != nil
      @transaction_list.delete(transaction)
    end
  end
end
