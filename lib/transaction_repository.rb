require 'CSV'
require_relative 'transaction'

class TransactionRepository
  attr_reader :file_path, :all, :transactions, :id

  def initialize(file_path, engine)
    @file_path = file_path
    @engine = engine
    @transactions = []
  end

  def create_repo
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      transaction = TransactionRepository.new(row, self)
      @transactions << transaction
    end
    self
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end

  def all
    transactions
  end

  def find_by_id(id)
    transactions.find do |transaction|
      transaction.id == id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    transactions.find do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def find_all_by_credit_card_number(credit_card_number)
    transactions.find_all do |transaction|
      transaction.credit_card_number.include?(credit_card_number)
    end
  end

  def find_all_by_result(result)
    transactions.find_all do |transaction|
      transaction.result == result
    end
  end

  def create(attributes)
    transaction_id = transactions.max { |transaction| transaction.id}
    attributes[:id] = transaction_id.id + 1
    @transactions << Transaction.new(attributes, self)
  end

  def update(id, attributes)
    transaction_by_id = find_by_id(id)
    if transaction_by_id != nil
      transaction_by_id.change_credit_card_number(attributes[:credit_card_number])
      transaction_by_id.change_credit_card_expiration_date(attributes[:credit_card_expiration_date])
      transaction_by_id.update_result(attributes[:result])
    end
  end

  def delete(id)
    chopping_block = transactions.index { |transaction| transaction.id == id}
    if chopping_block != nil
      transactions.delete_at(chopping_block)
    end
  end
end
