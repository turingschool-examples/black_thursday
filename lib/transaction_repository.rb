require_relative 'repository'
require_relative 'transaction'

class TransactionRepository < Repository

  def record_class
    Transaction
  end

  def find_all_by_invoice_id(invoice_id)
    find_all {|transaction| transaction.invoice_id == invoice_id}
  end

  def find_all_by_credit_card_number(credit_card_number)
    find_all {|transaction| transaction.credit_card_number == credit_card_number}
  end

  def find_all_by_result(result)
    find_all {|transaction| transaction.result == result}
  end

end
