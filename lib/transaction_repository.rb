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

  def find_all_by_credit_card_number(credit_card_n)
    @collection.values.select do |transaction|
      transaction.credit_card_number == credit_card_n
    end
  end

end
