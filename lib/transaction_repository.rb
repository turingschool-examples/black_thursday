require_relative'../lib/transaction.rb'
require_relative './sales_engine.rb'
require_relative'../lib/repository_helper.rb'
require 'time'
require 'csv'

class TransactionRepository
  include RepositoryHelper
  attr_reader :transactions,
              :all
  def initialize(filepath)
    @filepath = filepath
    @transactions = []
    @all = []
  end

  def create_transactions
    CSV.foreach(@filepath, headers: true, header_converters: :symbol) do |row|
      @all << Transaction.new(row)
    end
  end
  def find_all_by_credit_card_number(credit_card_number)
   @all.find_all do |transaction|
     transaction.credit_card_number == credit_card_number
   end
 end

 def find_all_by_result(result)
   @all.find_all do |transaction|
     transaction.result == result.to_sym
   end
 end

 def create(attributes)
   id = create_id
   transaction = Transaction.new(
     id: id,
     invoice_id: attributes[:invoice_id],
     credit_card_number: attributes[:credit_card_number],
     credit_card_expiration_date: attributes[:credit_card_expiration_date],
     result: attributes[:result],
     created_at: Time.now,
     updated_at: Time.now
     )
   @all << transaction
   transaction
 end

 def update(id, attributes)
   transaction = find_by_id(id)
   return if transaction.nil?
   transaction.credit_card_number = attributes[:credit_card_number] || transaction.credit_card_number
   transaction.credit_card_expiration_date = attributes[:credit_card_expiration_date] || transaction.credit_card_expiration_date
   transaction.result = attributes[:result].to_sym unless attributes[:result].nil?
   transaction.updated_at = Time.now
   transaction
 end
  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end
end
