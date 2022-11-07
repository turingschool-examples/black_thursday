require_relative 'repository'
require_relative 'transaction'

class TransactionRepository < Repository
  def new_obj(attributes)
    new_obj_class(attributes, Transaction)
  end

  def find_all_by_invoice_id(id)
    @repo.select { |invoice_item| invoice_item.invoice_id == id }
  end

  def find_all_by_credit_card_number(cc)
    @repo.select do |transaction|
        transaction.credit_card_number == cc
    end
  end

  def find_all_by_result(result)
    @repo.select do |transaction|
        transaction.result == result
    end
  end

end
