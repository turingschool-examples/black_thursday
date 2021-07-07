require_relative 'repository'
require_relative 'transaction'

class TransactionRepository
  include Repository

  def initialize
    @transactions = []
  end

  def inspect
    "#<#{self.class} #{all.size} rows>"
  end

  def all
    @transactions
  end

  def create_with_id(attributes)
    @transactions << Transaction.new(attributes)
  end

  def child_class
    Transaction
  end

  def create(attributes)
    all << child_class.create(attributes)
  end

  def find_all_by_invoice_id(invoice_id)
    all.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def find_all_by_credit_card_number(card_number)
    all.find_all do |transaction|
      transaction.credit_card_number == card_number
    end
  end

  def find_all_by_result(result)
    all.find_all do |transaction|
      transaction.result == result
    end
  end

  def update(id, attributes)
    transaction = find_by_id(id)
    return nil if transaction.nil?
    transaction.credit_card_number = attributes[:credit_card_number] unless attributes[:credit_card_number].nil?
    transaction.credit_card_expiration_date = attributes[:credit_card_expiration_date] unless attributes[:credit_card_expiration_date].nil?
    transaction.result = attributes[:result] unless attributes[:result].nil?
    transaction.updated_at = Time.now
  end

end
