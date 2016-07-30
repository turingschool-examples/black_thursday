require_relative './transaction'

class TransactionRepo
  def initialize(sales_engine = nil)
    @transactions = []
    @sales_engine = sales_engine
  end
  
  def all 
    @transactions
  end
  
  def add_transaction(transaction_details)
    @transactions << Transaction.new(transaction_details)
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
    @transactions.find_all do |transaction|
      transaction.result == result
    end
  end
end



