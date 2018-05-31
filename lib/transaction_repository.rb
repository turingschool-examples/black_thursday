require_relative 'transaction'
require 'pry'
class TransactionRepository

  attr_reader :transactions

  def initialize
    @transactions = []
  end

  def create(attributes)
    if attributes[:id].nil?
      id = @transactions[-1].id + 1
    else
      id = attributes[:id]
    end
    new_transaction = Transaction.new({id: id, invoice_id: attributes[:invoice_id],
                      credit_card_number: attributes[:credit_card_number],
                      credit_card_expiration_date: attributes[:credit_card_expiration_date],
                      result: attributes[:result],
                      created_at: attributes[:created_at].to_s,
                      updated_at: attributes[:updated_at].to_s})
    @transactions << new_transaction
    return new_transaction
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

  def update(id, attributes)
    if find_by_id(id).nil?
      return
    else
      updated_transaction = find_by_id(id)
    end
    updated_transaction.credit_card_number ||= attributes[:credit_card_number]
    updated_transaction.credit_card_expiration_date ||= attributes[:credit_card_expiration_date]
    updated_transaction.result = attributes[:result]
    updated_transaction.updated_at = Time.now
  end

  def delete(id)
    deleted_transaction = find_by_id(id)
    @transactions.delete(deleted_transaction)
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end
end
