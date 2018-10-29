require_relative './repository'
require_relative './transaction'

class TransactionRepository < Repository

  def new_record(row)
    Transaction.new(row)
  end

  def find_all_by_credit_card_number(credit_card_number)
    @all.find_all do |transaction|
      transaction.credit_card_number == credit_card_number
    end
  end

  def find_all_by_result(result_status)
    @all.find_all do |transaction|
      transaction.result == result_status
    end
  end

  def create(attributes)
    attributes[:id] = new_highest_id
    @all << new_item = Transaction.new(attributes)
    new_item
  end

  def update(id, attributes)
    transaction = find_by_id(id)
    return transaction if transaction.nil?
    transaction.credit_card_number = attributes[:credit_card_number] unless attributes[:credit_card_number].nil?
    transaction.credit_card_expiration_date = attributes[:credit_card_expiration_date] unless attributes[:credit_card_expiration_date].nil?
    transaction.result = attributes[:result] unless attributes[:result].nil?
    transaction.updated_at = Time.now
  end

end
