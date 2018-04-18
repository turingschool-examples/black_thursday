# frozen_string_literal: true

require_relative 'base_repository'
require_relative 'transaction'

# transaction repo
class TransactionRepository < BaseRepository
  def transactions
    @models
  end

  def populate
    @models ||= csv_table_data.map { |attribute_hash| Transaction.new(attribute_hash, self) }
  end

  def find_all_by_invoice_id(id)
    transactions.select { |transaction| transaction.invoice_id == id }
  end

  def find_all_by_credit_card_number(card_number)
    transactions.select do |transaction|
      transaction.credit_card_number == card_number
    end
  end

  def find_all_by_result(result)
    transactions.select { |transaction| transaction.result == result }
  end

  def create(attributes)
    attributes[:id] = create_new_id
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    transactions << Transaction.new(attributes, 'parent')
  end

  def update(id, attributes)
    return nil if find_by_id(id).nil?
    to_update = find_by_id(id)
    to_update.change_result(attributes[:result]) if attributes[:result]
    to_update.change_updated_at
    to_update.change_credit_card_number(attributes[:credit_card_number])
    if attributes[:credit_card_expiration_date]
      to_update.change_expiration_date(attributes[:credit_card_expiration_date])
    end
  end
end
