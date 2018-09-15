require 'time'

class Transaction
  attr_reader :id,
              :created_at,
              :invoice_id
  attr_accessor :credit_card_expiration_date,
                :credit_card_number,
                :updated_at,
                :result

  def initialize(hash)
    @id = hash[:id].to_i
    @invoice_id = hash[:invoice_id].to_i
    @credit_card_number = hash[:credit_card_number]
    @credit_card_expiration_date = hash[:credit_card_expiration_date]
    @result = hash[:result]
    @created_at = Time.parse(hash[:created_at].to_s)
    @updated_at = Time.parse(hash[:updated_at].to_s)
  end

end
