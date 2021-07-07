require_relative 'transaction.rb'
require_relative 'repository_helper.rb'

class TransactionRepository
  include RepositoryHelper
  attr_reader :repository

  def initialize(file_contents)
    @repository = file_contents.map { |transaction| Transaction.new(transaction) }
  end

  def find_all_by_credit_card_number(cc_number)
    @repository.select { |transaction| transaction.credit_card_number == cc_number }
  end

  def find_all_by_result(result)
    @repository.select { |transaction| transaction.result == result }
  end

  def create(attributes)
    sorted = @repository.sort_by(&:id)
    new_id = sorted.last.id + 1
    attributes[:id] = new_id
    new_transaction = Transaction.new(attributes)
    @repository << new_transaction
    new_transaction
  end

  def update(id, attributes)
    transaction = find_by_id(id)
    return if transaction.nil?
    attributes.each do |key, value|
      transaction.credit_card_number = value if key == :credit_card_number
      transaction.credit_card_expiration_date = value if key == :credit_card_expiration_date
      transaction.result = value if key == :result
      transaction.updated_at = Time.now + 1
    end
  end

  def inspect
    "#<#{self.class} #{@repository.size} rows>"
  end
end
