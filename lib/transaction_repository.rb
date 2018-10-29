require_relative './repository'

class TransactionRepository < Repository

  def initialize
    @collection = {}
  end

  def add_transaction(transaction)
    @collection[transaction.id] = transaction
  end

  def find_all_by_invoice_id(invoice_id)
    all.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def find_all_by_credit_card_number(credit_card_n)
    all.find_all do |transaction|
      transaction.credit_card_number == credit_card_n
    end
  end

  def find_all_by_result(result)
    all.find_all do |transaction|
      transaction.result == result
    end
  end

  def create(attributes)
    attributes[:id] = find_new_id
    add_transaction(Transaction.new(attributes))
  end

  def update(id, attributes)
    transaction_to_update = find_by_id(id)
    return nil if transaction_to_update == nil
    transaction_to_update.result = attributes[:result] if attributes.has_key?(:result)
    transaction_to_update.credit_card_number = attributes[:credit_card_number] if attributes.has_key?(:credit_card_number)
    transaction_to_update.credit_card_expiration_date = attributes[:credit_card_expiration_date] if attributes.has_key?(:credit_card_expiration_date)
    transaction_to_update.updated_at = Time.now
  end

end
