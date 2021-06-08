require 'csv'
require 'bigdecimal'
require_relative '../lib/transaction'
require_relative '../lib/modules/findable'
require_relative '../lib/modules/crudable'

class TransactionRepository
  include Findable
  include Crudable
  attr_reader :all

  def initialize(path)
    @all = []
    create_items(path)
  end

  def create_items(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      transaction = Transaction.new(row)
      @all << transaction
    end
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end

  def find_by_id(id)
    @all.find do |item|
      item.id == id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @all.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def find_all_by_credit_card_number(credit_card_number)
    @all.find_all do |transaction|
      transaction.credit_card_number == credit_card_number
    end
  end

  def find_all_by_result(result)
    @all.find_all do |transaction|
      transaction.result == result
    end
  end

  def create(attributes)
    create_new(attributes, Transaction)
    # new_id = @all.max_by do |transaction|
    #   transaction.id
    # end
    #
    # attributes[:id] = new_id.id + 1
    #
    # transaction = Transaction.new(attributes)
    # @all << transaction
    # transaction
  end

  def update(id, attributes)
    transaction = find_by_id(id)
    return transaction.update(attributes) unless transaction.nil?
  end

  def delete(id)
    delete_new(id)
    # delete_transaction = find_by_id(id)
    # @all.delete(delete_transaction)
  end
end
