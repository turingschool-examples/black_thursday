# frozen_string_literal: true

require 'csv'
require_relative 'transaction'


class TransactionRepository
  attr_reader :all

  def initialize(path)
    @all = generate(path)
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end

  def generate(path)
    rows = CSV.read(path, headers: true, header_converters: :symbol)

    rows.map do |row|
      Transaction.new(row)
    end
  end

  def find_by_id(id)
    @all.find do |transaction|
      id == transaction.id
    end
  end

  def find_all_by_invoice_id(id)
    @all.find_all do |transaction|
      id == transaction.invoice_id
    end
  end

  def find_all_by_credit_card_number(number)
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
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s

    @all << Transaction.new(attributes)
  end

  def update(id, attributes)
    txn_to_update = find_by_id(id)
    cc_num        = attributes[:credit_card_number]
    cc_expiration = attributes[:credit_card_expiration_date]
    result        = attributes[:result]

    txn_to_update.credit_card_number = cc_num if cc_num
    txn_to_update.credit_card_expiration_date = cc_expiration if cc_expiration
    txn_to_update.result = result if result
    if txn_to_update != nil
      txn_to_update.updated_at = Time.now
    end 
    txn_to_update
  end

  def delete(id)
    @all.delete(find_by_id(id))
  end
end
