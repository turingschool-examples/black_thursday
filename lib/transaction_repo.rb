# frozen_string_literal: true

require './lib/transaction'
require './lib/general_repo'

# This is the transaction_repository class
class TransactionRepo < GeneralRepo
  def initialize(data)
    super(data)
  end

  def create(stat)
    stat[:id] ||= (@repository.last.id.to_i + 1).to_s
    item = Transaction.new(stat)
    @repository.push(item)
  end

  def find_all_by_invoice_id(id)
    @repository.select { |item| item.invoice_id == id }
  end

  def find_all_by_credit_card_number(card_number)
    @repository.select { |item| item.credit_card_number.casecmp?(card_number) }
  end

  def find_all_by_result(result)
    @repository.select { |item| item.result.casecmp?(result) }
  end
end
