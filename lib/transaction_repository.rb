require_relative './repository'

class TransactionRepository < Repository

  def initialize
    @collection = {}
  end

  def add_transaction(transaction)
    @collection[transaction.id] = transaction
  end

  def find_all_by_invoice_id(invoice_id)
    @collection.values.select do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

end
