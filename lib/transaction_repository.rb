# frozen_string_literal: true

require_relative 'transaction'
# This class holds our transactions and gives us methods to interact with them.
class TransactionRepository
  attr_reader :repository,
              :parent
  def initialize(transactions, parent)
    @repository = transactions.map do |transaction|
      Transaction.new(transaction, parent)
    end
    @parent = parent
  end

  def all
    @repository
  end

  def find_by_id(id)
    @repository.find { |transaction| transaction.id == id }
  end

  def find_all_by_invoice_id(invoice_id)
    @repository.find_all { |transaction| transaction.invoice_id == invoice_id }
  end

  def find_all_by_credit_card_number(credit_card_num)
    @repository.find_all do |transaction|
      transaction.credit_card_number == credit_card_num
    end
  end

  def find_all_by_result(result)
    @repository.find_all { |transaction| transaction.result == result }
  end

  def update(id, attributes)
    transaction = find_by_id(id)
    unchangeable_keys = %i[id transaction_id created_at]
    attributes.each do |key, value|
      next if (attributes.keys & unchangeable_keys).any?
      if transaction.transaction_specs.keys.include?(key)
        transaction.transaction_specs[key] = value
        transaction.transaction_specs[:updated_at] = Time.now
      end
    end
  end

  def create(attributes)
    id_array = @repository.map(&:id)
    new_id = id_array.max + 1
    attributes[:id] = new_id.to_s
    @repository << Transaction.new(attributes, self)
  end

  def delete(id)
    transaction_to_delete = find_by_id(id)
    @repository.delete(transaction_to_delete)
  end

  def group_transactions
    @repository.group_by(&:result)
  end

  def find_invoice_by_invoice_id(invoice_id)
    @parent.find_invoice_by_invoice_id(invoice_id)
  end

  def inspect
    "<#{self.class} #{@repository.size} rows>"
  end
end
