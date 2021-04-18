require_relative 'sales_engine'
require_relative 'transaction'
require_relative 'mathable'

class TransactionRepository
  include Mathable
  attr_reader :transactions

  def initialize(path, engine)
    @transactions = []
    @engine = engine
    make_transactions(path)
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end

  def make_transactions(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      @transactions << Transaction.new(row, self)
    end
  end

  def all
    @transactions
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

  def find_all_by_credit_card_number(credit_card_number)
    @transactions.find_all do |transaction|
      transaction.credit_card_number == credit_card_number
    end
  end

  def find_all_by_result(result)
    @transactions.find_all do |transaction|
      transaction.result == result
    end
  end

  def generate_new_id
    highest_id_transaction = @transactions.max_by do |transaction|
      transaction.id
    end
    highest_id_transaction.id + 1
  end

  def create(attributes)
    attributes[:id] = generate_new_id
    attributes[:created_at] = attributes[:created_at].to_s
    attributes[:updated_at] = attributes[:created_at].to_s
    @transactions << Transaction.new(attributes, self)
  end

  def update(id, attributes)
    if find_by_id(id) != nil 
      invoice_to_update = find_by_id(id)
      invoice_to_update.update(attributes)
    end
  end

  def delete(id)
    transactions.delete(find_by_id(id))
  end
end
