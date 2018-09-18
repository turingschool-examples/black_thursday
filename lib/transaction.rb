class Transaction

  attr_reader :id,
              :invoice_id,
              :created_at,
              :updated_at

  attr_accessor :credit_card_number,
                :credit_card_expiration_date,
                :result

  def initialize(hash)
   
    @id                 = hash[:id].to_i
    @invoice_id         = hash[:invoice_id].to_i
    @created_at         = hash[:created_at]
    @updated_at         = hash[:updated_at]
    
    @credit_card_number = hash[:credit_card_number]
    @credit_card_expiration_date = hash[:credit_card_expiration_date]
    @result             = hash[:result].to_sym    # TO DO - TEST ME 
  end
  
end
