require 'time'

class Transaction
  attr_accessor :id,
                :invoice_id,
                :credit_card_number,
                :credit_card_expiration_date,
                :result,
                :created_at

  def initialize(data)
    @id = data[:id].to_i
    @invoice_id = data[:invoice_id].to_i
    @credit_card_number = data[:credit_card_number]
    @credit_card_expiration_date = data[:credit_card_expiration_date]
    @result = data[:result]
    @created_at = Time.parse(data[:created_at])
  end
end