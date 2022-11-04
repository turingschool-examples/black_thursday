require_relative 'transaction'

require_relative 'repo_module'

class TransactionRepository
  include RepoModule
  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end
  attr_reader :transaction
  def initialize(transactions)
    @transaction = transactions
  end
  
  def all
    @transactions
  end
  
  def find_by_id
  end
  
  def find_all_by_credit_card_number
  end
  
  def find_all_by_result
  end
  
  def create(attributes)
  end
  
  def delete(id)
  end

  # def update(id, attribute)
  #   if all_ids.include?(id)
  #     updated_t = find_by_id(id)
  #     if attributes[:credit_card_number] != nil
  #       updated_t.update_credit_card_number(attributes[:credit_card_number])
  #     end
  #     if attributes[:credit_card_expiration_date] != nil
  #       updated_t.update_credit_card_expiration_date(attributes[:credit_card_expiration_date])
  #     end
  #     if attributes[:result] != nil
  #       updated_t.update_result(attributes[:result])
  #     end
  #     updated_t.update_time
  #     updated_t
  #   end
  # end
end