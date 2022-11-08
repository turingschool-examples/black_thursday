require_relative 'repository'

class TransactionRepository < Repository
  def find_all_by_invoice_id(invoice_id)
    @all.find_all do |item|
      item.invoice_id == invoice_id
    end
  end
  
  def find_all_by_credit_card_number(credit_card_number)
    @all.find_all do |number|
      number.credit_card_number == credit_card_number
    end
  end

  def find_all_by_result(result)
    @all.select do |results|
      results.result == result
    end
  end

  def update(id, attributes)
    sanitized_attributes = {
      credit_card_number: attributes[:credit_card_number],
      credit_card_expiration_date: attributes[:credit_card_expiration_date],
      result: attributes[:result],
      updated_at: Time.now
    }.compact
    super(id, sanitized_attributes)
  end
end