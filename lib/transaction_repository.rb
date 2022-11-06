require_relative '../lib/modules/repo_queries'
require_relative '../lib/merchant'
require 'csv'

class TransactionRepository
  include RepoQueries

  attr_accessor :data

  def initialize(file = nil, engine = nil)
    @data = []
    @engine = engine
    @child = Transaction
    load_data(file)
  end

  def find_all_by_invoice_id(invoice_id)
    all.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def find_all_by_credit_card_number(credit_card_number)
    all.find_all do |transaction|
      transaction.credit_card_number == credit_card_number
    end
  end

  def find_all_by_result(result)
    all.find_all do |transaction|
      transaction.result == result
    end
  end

  def update(id, attributes)
    return if attributes.empty?
    updated = find_by_id(id)
    updated.credit_card_number = attributes[:credit_card_number]
    updated.credit_card_expiration_date = attributes[:credit_card_expiration_date]
    updated.result = attributes[:result]
    updated.updated_at = Time.now
  end

  def child
    Transaction
  end
end
