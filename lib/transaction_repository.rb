# frozen_string_literal: true

require 'transaction'
require 'csv'

class TransactionRepository
  attr_reader :path,
              :all

  def initialize(path)
    @path = path
    @all  = read_file
  end

  def read_file
    rows = CSV.read(@path, headers: true, header_converters: :symbol)

    rows.map do |row|
      Transaction.new(row)
    end
  end

  def find_by_id(id)
    @all.find do |transaction|
      id == transaction.id
    end
  end

  def find_by_invoice_id(id)
    @all.find do |transaction|
      id == transaction.invoice_id
    end
  end

  def find_by_credit_card_number(number)
    @all.find_all do |transaction|
      number == transaction.credit_card_number
    end
  end

  def find_all_by_result(result)
    @all.find_all do |transaction|
      result == transaction.result
    end
  end

  def create(attributes)
    attributes[:id] = @all.last.id + 1
    @all << Transaction.new(attributes)
  end

  def update(id, attributes)
    transaction_to_update = find_by_id(id)
    transaction_to_update.credit_card_number = attributes[:credit_card_number] if attributes[:credit_card_number]
    transaction_to_update.credit_card_expiration_date = attributes[:credit_card_expiration_date] if attributes[:credit_card_expiration_date]
    transaction_to_update.result = attributes[:result] if attributes[:result]
    transaction_to_update.updated_at = Time.now
    transaction_to_update
  end

  def delete(id)
    @all.delete(find_by_id(id))
  end
end
