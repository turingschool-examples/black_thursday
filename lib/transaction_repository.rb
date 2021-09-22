# frozen_string_literal: true

# TransactionRepository class for Black Thursday

require 'transaction'

class TransactionRepository
  attr_reader :all

  def initialize(file)
    @all = transaction_builder(file)
  end

  def transaction_builder(file)
    all_transactions = CSV.parse(File.read(file))
    categories = all_transactions.shift
    all_transactions.map do |transaction|
      individual_transaction = {}
      categories.zip(transaction) do |category, attribute|
        individual_transaction[category.to_sym] = attribute
      end
      Transaction.new(individual_transaction)
    end
  end

  def find_by_id(id)
    all.find do |transaction|
      transaction.id == id
    end
  end

  def find_all_by_invoice_id(id)
    all.find_all do |transaction|
      transaction.invoice_id == id
    end
  end

  def find_all_by_cc_num(number)
    all.find_all do |transaction|
      transaction.cc_num.to_i == number
    end
  end

  def find_all_by_result(result)
    all.find_all do |transaction|
      transaction.result == result
    end
  end

  def create(attributes)
    creation_time = Time.now
    all << Transaction.new(
      id: highest_id_transaction.id + 1,
      invoice_id: attributes[:invoice_id],
      cc_num: attributes[:cc_num],
      credit_card_expiration_date: attributes[:credit_card_expiration_date],
      result: attributes[:status],
      created_at: creation_time,
      updated_at: creation_time
    )
  end

  def highest_id_transaction
    all.max_by(&:id)
  end

  def update(id, attributes)
    find_by_id(id).update(attributes)
  end

  def delete(id)
    all.delete(find_by_id(id))
  end

  def inspect
    "#<#{self.class} #{all.size} rows>"
  end
end
