require_relative 'transaction'

require_relative 'repo_module'

class TransactionRepository
  include RepoModule
  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end
  attr_reader :transactions
  def initialize(transactions)
    @transactions = transactions
  end
  
  def all
    @transactions
  end
  
  def find_by_id(id)
    @transactions.find {|transaction| transaction.id == id}
  end
  
  def find_all_by_credit_card_number(ccn)
    @transactions.find_all {|transaction| transaction.credit_card_number == ccn}
  end
  
  def find_all_by_result(result)
    @transactions.find_all {|transaction| transaction.result == result}
  end
  
  def create(attributes)
    ids = all_ids
    attributes[:id] = ids.max + 1
    new_transaction = Transaction.new(attributes)
    @transactions.push(new_transaction)
    new_transaction
  end
  
  def delete(id)
  end

  def update(id, attributes)
    if all_ids.include?(id)
      updated_t = find_by_id(id)
      if attributes[:credit_card_number] != nil
        updated_t.update_credit_card_number(attributes[:credit_card_number])
      end
      if attributes[:credit_card_expiration_date] != nil
        updated_t.update_credit_card_expiration_date(attributes[:credit_card_expiration_date])
      end
      if attributes[:result] != nil
        updated_t.update_result(attributes[:result])
      end
      updated_t.update_time
      updated_t
    end
  end
  
  def delete(id)
    @transactions.delete(find_by_id(id))
  end
end