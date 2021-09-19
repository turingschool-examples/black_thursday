require 'csv'
require_relative '../lib/transaction'
require_relative '../lib/repo_module'

class TransactionRepo
  include Repo
  attr_reader :all

  def initialize(path)
    @path = path
    @all = to_array
  end

  def create_array_of_objects(things)
    things.map do | transaction |
      Transaction.new(transaction)
    end
  end

  def find_all_by_credit_card_number(credit_card_number)
    all.select do |transaction|
      credit_card_number == transaction.credit_card_number
    end
  end

  def find_all_by_invoice_id(invoice_id)
    all.select do |transaction|
      invoice_id == transaction.invoice_id
    end
  end

  def create(attributes)
    id = find_highest_id + 1
    attributes = {
                  id: id.to_s,
                  invoice_id: attributes[:invoice_id],
                  credit_card_number: attributes[:credit_card_number],
                  credit_card_expiration_date: attributes[:credit_card_expiration_date],
                  result: attributes[:result],
                  created_at: attributes[:created_at].to_s,
                  updated_at: attributes[:updated_at].to_s
                 }
    @all << Transaction.new(attributes)
    end

  def update(id, attributes)
    transaction = find_by_id(id)
    transaction.change_credit_card_number(attributes[:credit_card_number])
    transaction.change_credit_card_expiration_date(attributes[:credit_card_expiration_date])
    transaction.change_result(attributes[:result])
  end
end
