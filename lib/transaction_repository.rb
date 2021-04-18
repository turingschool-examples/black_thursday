require_relative '../lib/transaction'
require_relative '../lib/repository'

class TransactionRepository < Repository

  def initialize(path)
    super(path)
    @array_of_objects = create_transactions(@parsed_csv_data)
  end

  def create_transactions(parsed_csv_data)
    parsed_csv_data.map do |transaction|
      Transaction.new(transaction)
    end
  end

  def create(attributes)
    max_id = @array_of_objects.max_by do |transaction|
      transaction.id
    end.id

    new_transaction = Transaction.new(attributes)
    new_transaction.id = max_id + 1
    @array_of_objects << new_transaction
  end

  def update(id, attributes)
    target = find_by_id(id)
    if target != nil
      target.credit_card_number = attributes[:credit_card_number] if attributes[:credit_card_number] != nil
      target.credit_card_expiration_date = attributes[:credit_card_expiration_date] if attributes[:credit_card_expiration_date] != nil
      target.result = attributes[:result] if attributes[:result] != nil
      target.updated_at = Time.now
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @array_of_objects.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
  end
end
