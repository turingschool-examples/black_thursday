require_relative 'transaction'

class TransactionRepo 
  attr_accessor :transactions

  def initialize(transactions)
    @transactions = transactions 
    change_transaction_hash_to_object
  end
  
  def change_transaction_hash_to_object
    transaction_array = []
    @transactions.each do |transaction|
      transaction_array << Transaction.new(transaction)
    end
    @transactions = transaction_array
  end

  def all 
    @transactions
  end
  
  def find_by_id(id)
    @transactions.find do |transaction|
      transaction.id == id
    end
  end 
  
  def find_all_by_invoice_id(invoice_id)
    @transactions.find_all do |transaction|
      transaction.invoice_id == invoice_id
    end
  end 
  
  def find_all_by_credit_card_number(credit_card_number)
    @transactions.find_all do |transaction|
      transaction.credit_card_number == credit_card_number
    end
  end

  def find_all_by_result(result) 
    @transactions.find_all do |transactions|
        transactions.result == result
      end
    end
  end 
  
  def create(attributes) 
    transaction_new = Transaction.new(attributes)
    max_transaction_id = @transactions.max_by do |transaction|
      transaction.id
    end
    new_max_id = max_transaction_id.id + 1
    transaction_new.id = new_max_id
    @transactions << transaction_new
    return transaction_new 
  end 
  
  def update(id, attribute) 
    transaction_to_change = find_by_id(id)
    return if transaction_to_change.nil?
    transaction_to_change.updated_at = Time.now
    transactions_to_change.credit_card_number = attributes[:credit_card_number]
    transactions_to_change.credit_card_expiration_date = attributes[:credit_card_expiration_date]
    transactions_to_change.result = attributes[:result]
    transaction_to_change 
  end 
  
  def delete(id)
    transaction_to_delete = find_by_id(id)
    @transactions.delete(transaction_to_delete)
  end
  