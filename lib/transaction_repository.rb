require 'csv'
require_relative './sales_engine'
require_relative './transaction'
require_relative './inspectable'

class TransactionRepository
  include Inspectable
  def initialize(data)
     @transactions = data
  end

  def all
    @transactions
  end

  def find_by_id(id)
    transaction_id = nil
    @transactions.select do |transaction|
      transaction_id = transaction if transaction.id == id
    end
    transaction_id
  end

  def find_all_by_invoice_id(id)
    @transactions.find_all do |transaction|
      if transaction.invoice_id == id
        transaction
      end
    end
  end

  def find_all_by_credit_card_number(ccnum)
    @transactions.find_all do |transaction|
      if transaction.credit_card_number == ccnum
        transaction
      end
    end
  end

  def find_all_by_result(result)
    @transactions.find_all do |transaction|
      if transaction.result == result
        transaction
      end
    end
  end

  def highest_id
    new = @transactions.max_by(&:id)
    new.id + 1
  end

  def create(attributes)
    new_transaction = [highest_id,
                      attributes[:invoice_id],
                      attributes[:credit_card_number],
                      attributes[:credit_card_expiration_date],
                      attributes[:result],
                      Time.now.strftime('%Y-%m-%d'),
                      Time.now.strftime('%Y-%m-%d')]
    new = Transaction.new(new_transaction)
    @transactions << new
  end

  def update(id, attribute)
    @transactions.map do |transaction|
      if transaction.id == id
        transaction.credit_card_number = attribute[:credit_card_number] if attribute.keys.include?(:credit_card_number)
        transaction.credit_card_expiration_date = attribute[:credit_card_expiration_date] if attribute.keys.include?(:credit_card_expiration_date)
        transaction.credit_card_expiration_date = attribute[:credit_card_expiration_date] if attribute.keys.include?(:credit_card_expiration_date)
        transaction.result = attribute[:result] if attribute.keys.include?(:result)
        transaction.updated_at = Time.now
      end
    end
  end

  def delete(id)
    trash = @transactions.find do |transaction|
      transaction.id == id
    end
    @transactions.delete(trash)
  end
end
