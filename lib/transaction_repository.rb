require_relative 'transaction'
require_relative 'sales_engine'
require 'csv'
class TransactionRepo
  attr_reader:path,
             :engine,
             :transactions
  def initialize(path, engine)
    @path = path
    @engine = engine
    @transactions = []
    read_transactions
  end

  def read_transactions
    CSV.foreach(@path, headers: true, header_converters: :symbol) do |row|
      @transactions << Transaction.new(row, self)
    end
    @transactions
  end

  def all
    @transactions
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end

  def find_by_id(id)
    @transactions.find do |transaction|
      transaction.id == id
    end
  end

  def find_all_by_credit_card_number(credit_card)
    @transactions.find_all do |transaction|
      transaction.credit_card_number == credit_card
    end
  end

  def find_all_by_result(result)
    @transactions.find_all do |transaction|
      transaction.result == result
    end
  end

  def highest_id
    @transactions.max_by do |transaction|
      transaction.id
    end
  end

  def create(attributes)
    attributes[:id] = highest_id.id + 1
    @transactions << Transaction.new(attributes, self)
  end

  def update(id, attributes)
    update = find_by_id(id)
    return nil if update.nil?
    update.credit_card_number = attributes[:credit_card_number] if attributes.has_key?(:credit_card_number)
    update.credit_card_expiration_date = attributes[:credit_card_expiration_date] if attributes.has_key?(:credit_card_expiration_date)
    update.result = attributes[:result] if attributes.has_key?(:result)
    update.updated_at = Time.now
  end

  def delete(id)
    delete = find_by_id(id)
    @transactions.delete(delete)
  end
end
