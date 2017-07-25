class TransactionRepository
  

  # The TransactionRepository is responsible for holding and searching our Transaction instances.
  def all
    # all - returns an array of all known Transaction instances
  end

  def find_by_id
    # find_by_id - returns either nil or an instance of Transaction with a matching ID
  end

  def find_all_by_invoice_id
    # find_all_by_invoice_id - returns either [] or one or more matches which have a matching invoice ID
  end

  def find_all_by_credit_card_number
    # find_all_by_credit_card_number - returns either [] or one or more matches which have a matching credit card number
  end

  def find_all_by_result
    # find_all_by_result - returns either [] or one or more matches which have a matching status
  end




end
