require_relative 'transaction'
require_relative 'repo_methods'

class TransactionRepository
  include RepoMethods

  def initialize(transaction_data)
    @transaction_rows ||= build_transaction(transaction_data)
    @repo = @transaction_rows
  end

  def build_transaction(transaction_data)
    transaction_data.map do |transaction|
      Transaction.new(transaction)
    end
  end

  def find_all_by_credit_card_number(credit_card_number)
    @repo.find_all do |transaction|
      transaction.credit_card_number == credit_card_number
    end
  end

  def find_all_by_result(result)
    @repo.find_all do |transaction|
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
    @repo << transaction
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
end
