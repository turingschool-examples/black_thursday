require 'time'

class Transaction
  attr_reader :id,
              :invoice_id,
              :created_at

  attr_accessor :credit_card_number,
                :credit_card_expiration_date,
                :result,
                :updated_at

  def initialize(transaction)
    @id = transaction[:id].to_i
    @invoice_id = transaction[:invoice_id].to_i
    @credit_card_number = transaction[:credit_card_number]
    @credit_card_expiration_date = transaction[:credit_card_expiration_date]
    @result = transaction[:result]
    @created_at = Time.parse(transaction[:created_at].to_s)
    @updated_at = Time.parse(transaction[:updated_at].to_s)
  end

end
