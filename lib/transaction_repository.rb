

class TransactionRepository

  attr_accessor :repository

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @repository = []
  end

  def all?
    repository
  end

  def find_by_id(id)
    repository.find do |transaction|
      transaction.id == id
    end
  end

  def find_all_by_invoice_id(id)
    repository.find_all do |transaction|
      transaction.invoice_id == id
    end
  end

  def find_all_by_credit_card_number(number)
    repository.find_all do |transaction|
      transaction.credit_card_number == number
    end
  end

  def find_all_by_result(result)
    repository.find_all do |transaction|
      transaction.result == result.to_sym
    end
  end

end
