require 'csv'
require 'bigdecimal'
require 'time'
require_relative './transaction'

class TransactionRepository
  attr_reader :all,
              :engine

  def initialize(transaction_path, engine)
    @all = []
    @engine = engine

    CSV.foreach(transaction_path, headers: true, header_converters: :symbol) do |row|
      @all << convert_to_transaction(row)
    end
  end

  def convert_to_transaction(row)
    row = Transaction.new({
                id: row[:id],
                invoice_id: row[:invoice_id],
                credit_card_number: row[:credit_card_number],
                credit_card_expiration_date: row[:credit_card_expiration_date],
                result: row[:result],
                created_at: row[:created_at],
                updated_at: row[:updated_at]
                   }, self)
  end

  def find_by_id(id)
    @all.find do |transaction|
      transaction.id == id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @all.find_all do |transaction|
      transaction.invoice_id.include?(invoice_id.to_s)
    end
  end

  def find_all_by_credit_card_number(cc_number)
    @all.find_all do |transaction|
      transaction.credit_card_number.include?(cc_number)
    end
  end

  def find_all_by_result(result)
    @all.find_all do |transaction|
      transaction.result == result
    end
  end

  def new_highest_id
    all.max_by do |instance|
      instance.id
    end.id + 1
  end

  def create(attributes)
    attributes[:id] = new_highest_id
    transaction = Transaction.new(attributes, self)
    @all << transaction
    transaction
  end


  def check_result_is_valid(attributes)
   if attributes.class == Hash
      results = [:success, :failed]
      result = :"#{attributes[:result]}"
      results.include?(result)
    end
  end

  def update(id, attributes)
    # require "pry"; binding.pry
    if !find_by_id(id).nil? && check_result_is_valid(attributes)
      new_result = :"#{attributes[:result]}"
      update_transaction = all.find { |transaction| transaction.id == id }
      update_transaction.credit_card_number = attributes[:credit_card_number] if !attributes[:credit_card_number].nil?
      update_transaction.credit_card_expiration_date = attributes[:credit_card_expiration_date] if !attributes[:credit_card_expiration_date].nil?
      update_transaction.result = new_result if !attributes[:result].nil?
      update_transaction.updated_at = Time.now
    end
  end

  def delete(id)
    remove = find_by_id(id)
    @all.delete(remove)
  end

  def inspect
    "<#{self.class} #{@all.size} rows>"
  end
end
