require_relative '../lib/repository'


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
  
  
end