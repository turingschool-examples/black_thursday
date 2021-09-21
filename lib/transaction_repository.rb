require 'csv'
require_relative './sales_engine'
require_relative './transaction'

class TransactionRepository
  def initialize(data)
     @transactions = data
  end

  def all
    @transactions
  end

  def find_by_id(id)
    transaction_id = nil
    @transactions.select do |transaction|
      transaction_id = if transaction.id == id
    end
    transaction_id
  end
  end

  def find_all_by_invoice_id(id)
    @transactions.find_all do |transaction|
      if transaction.invoice_id == id
        transaction
      end
    end
  end

  def find_all_by_credit_card_number
  end

  def find_all_by_result
  end

  def create(attributes)
  end

  def update(id, attribute)
  end

  def delete(id)
  end


end
