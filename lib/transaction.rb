require 'time'
require 'bigdecimal'
class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at,
              :transaction_repo

  def initialize(data, transaction_repo)
    @id = data[:id].to_i
    @invoice_id = data[:invoice_id].to_i
    @credit_card_number = data[:credit_card_number]
    @credit_card_expiration_date = data[:credit_card_expiration_date]
    @result = data[:result].to_sym
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
    @transaction_repo = transaction_repo
  end

  def update_updated_at
    @updated_at = Time.now
  end

  def update_credit_card_number(number)
    @credit_card_number = number
  end

  def update_credit_card_expiration_date(date)
    @credit_card_expiration_date = date
  end

  def update_result(result)
    @result = result.to_sym
  end

  def invoice
    @transaction_repo.sales_engine.invoices.find_by_id(invoice_id)
  end
end
