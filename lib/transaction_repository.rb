require_relative './transaction'
require_relative './repository'

class TransactionRepository < Repository

  def initialize(filepath)
    super()
    load_items(filepath)
  end

  def load_items(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol ) do |datum|
      @data << Transaction.new(datum)
    end
  end

  def find_by_id(id)
    @data.find do |datum|
      datum.id == id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @data.find_all do |datum|
      datum.invoice_id == invoice_id
    end
  end

  def find_all_by_credit_card_number(credit_card_number)
    @data.find_all do |datum|
      datum.credit_card_number == credit_card_number
    end
  end

  def find_all_by_result(result)
    @data.find_all do |datum|
      datum.result == result
    end
  end

  def create(attributes)
    highest_id = @data.max_by do |datum|
      datum.id
    end.id
    new_transaction_id = highest_id += 1
    attributes[:id] = new_transaction_id
    new_transaction = Transaction.new(attributes)

    @data << new_transaction
    return new_transaction
  end

  def update(id, attributes)
    transaction = find_by_id(id)
    return if transaction.nil?
    attributes.each do |key, value|
      transaction.credit_card_number = value if key == :credit_card_number
      transaction.credit_card_expiration_date = value if key == :credit_card_expiration_date
      transaction.result = value if key == :result
    end
    current_time = Time.now + 1
    transaction.updated_at = current_time.to_s
  end

  def delete(id)
    transaction = find_by_id(id)
    @data.delete(transaction)
  end
end
