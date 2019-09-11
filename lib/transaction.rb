class Transaction
  attr_accessor     :id,
                    :invoice_id,
                    :credit_card_number,
                    :credit_card_expiration_date,
                    :result,
                    :created_at,
                    :updated_at

  def initialize(attributes)
    @id = attributes[:id].to_i
    @invoice_id = attributes[:invoice_id].to_i
    @credit_card_number = attributes[:credit_card_number].to_s
    @credit_card_expiration_date = attributes[:credit_card_expiration_date].to_s
    @result = attributes[:result].to_sym
    @created_at = time_conversion(attributes[:created_at])
    @updated_at = time_conversion(attributes[:updated_at])
  end

  def time_conversion(time)
    if time.class == String
      time = Time.parse(time)
    end
    time
  end
end
