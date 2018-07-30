require 'time'

class Transaction
  attr_accessor :id,
                :invoice_id,
                :credit_card_number,
                :credit_card_expiration_date,
                :result,
                :created_at,
                :updated_at

  def initialize(hash)
    @id = hash[:id].to_i
    @invoice_id = hash[:invoice_id].to_i
    @credit_card_number = hash[:credit_card_number]
    @credit_card_expiration_date = hash[:credit_card_expiration_date]
    @result = hash[:result].to_sym
    @created_at = if hash[:created_at].class == String
                  Time.parse(hash[:created_at])
                    else
                      Time.now
                  end
    @updated_at = if hash[:updated_at].class == String
                    Time.parse(hash[:updated_at])
                    else
                      Time.now
                    end
    @merchant_id = hash[:merchant_id].to_i
  end

end
