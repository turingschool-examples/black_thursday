require_relative '../lib/repository'
require_relative '../lib/transaction'

class TransactionRepository
    include Repository
    
  def initialize(transactions)
    @collection = transactions
  end
  
  def find_all_by_invoice_id(invoice_id)
    all.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
  end
  
  def find_all_by_credit_card_number(number)
    all.find_all do |transaction|
      transaction.credit_card_number == number
    end
  end
  
  def find_all_by_result(result)
    all.find_all do |transaction|
      transaction.result == result
    end
  end
  
  def create(attributes)
    attributes[:id] = max_id + 1
    attributes[:created_at] = Time.now
    attributes[:updated_at] = Time.now
    new_transaction = Transaction.new(attributes)
    @collection << new_transaction
    new_transaction
  end
  
  def update(id, attributes)
    t = find_by_id(id)
    
    t.credit_card_number = 
            attributes[:credit_card_number] if attributes[:credit_card_number]
    t.credit_card_expiration_date = 
            attributes[:credit_card_expiration_date] if attributes[:credit_card_expiration_date]
    t.result = attributes[:result] if attributes[:result]
    t.updated_at = Time.now
  end
  
end