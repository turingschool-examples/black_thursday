require 'time'

class Transaction

  def initialize(sales_engine, transaction_hash)
    @sales_engine = sales_engine
    @id = transaction_hash[:id]
    @invoice_id = transaction_hash[:invoice_id]
    @credit_card_number = transaction_hash[:credit_card_number]
    @credit_card_expiration_date = transaction_hash[:credit_card_expiration_date]
    @result = transaction_hash[:result]
    @created_at = transaction_hash[:created_at]
    @updated_at = transaction_hash[:updated_at]
  end

  def id
    @id.to_i
  end

  def invoice_id
    @invoice_id.to_i
  end

  def credit_card_number
    @credit_card_number.to_i
  end

  def credit_card_expiration_date
    @credit_card_expiration_date
  end

  def result
    @result
  end

  def created_at
    Time.parse(@created_at)
  end

  def updated_at
    Time.parse(@updated_at)
  end

  def inspect
    "id: #{id}"
  end


end
