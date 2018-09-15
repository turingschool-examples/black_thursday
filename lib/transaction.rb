require 'pry'

class Transaction

  attr_reader :id,
              :invoice_id,
              :created_at,
              :updated_at

  attr_accessor :credit_card_number,
                :credit_card_expiration_date,
                :result


  def initialize(hash)
    # -- Read Only --
    @id                 = hash[:id].to_i
    @invoice_id         = hash[:invoice_id].to_i
    @created_at         = hash[:created_at]
    @updated_at         = hash[:updated_at]
    # -- Accessible --
    @credit_card_number = hash[:credit_card_number]
    @credit_card_expiration_date = hash[:credit_card_expiration_date]
    @result             = hash[:result]
  end


end
