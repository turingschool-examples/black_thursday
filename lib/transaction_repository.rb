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
      transaction.find_all_by_credit_card_number == card_number
    end
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
    to_update.change_updated_at
    to_update.change_unit_price(attributes[:unit_price])
    to_update.change_quantity(attributes[:quantity])
  end

  def delete(id)
    to_delete = find_by_id(id)
    transactions.delete(to_delete)
  end

  private

  def find_highest_id
    transactions.map(&:id).max
  end

  def create_new_id
    find_highest_id + 1
  end

end
