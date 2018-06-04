require_relative 'repository'
require_relative 'transaction'

class TransactionRepository
  include Repository

  def initialize(loaded_file)
    @repository = loaded_file.map { |transaction| Transaction.new(transaction)}
  end

  def find_all_by_credit_card_number(card_num)
    all.find_all {|transaction| card_num == transaction.credit_card_number}
  end

  def find_all_by_result(result)
    all.find_all {|transaction| result == transaction.result}
  end

  def create(attributes)
    attributes[:id] = new_highest_id
    @repository.push(Transaction.new(attributes))
  end

  def update(id, attributes)
    transaction = find_by_id(id)
    return transaction if transaction.nil?
    transaction.update_credit_card_number(attributes[:credit_card_number]) unless attributes[:credit_card_number].nil?
    transaction.update_credit_card_expiration_date(attributes[:credit_card_expiration_date]) unless attributes[:credit_card_expiration_date].nil?
    transaction.update_result(attributes[:result]) unless attributes[:result].nil?
    transaction.new_update_time(Time.now.utc) unless attributes.empty?
  end
end
