class Transaction
  attr_accessor :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at

  def initialize(data)
    @id = data[:id]
    @invoice_id = data[:invoice_id]
    @credit_card_number = data[:credit_card_number]
    @credit_card_expiration_date = data[:credit_card_expiration_date]
    @result = data[:result]
    @updated_at = (data[:updated_at])
    @created_at = (data[:created_at])
  end

  def update(attributes)
    attributes.keys.each do |key|
      if key == :id || key == :invoice_id
        attributes.delete(key)
      end
    end
    @credit_card_number = attributes[:credit_card_number] if attributes[:credit_card_number]
    @credit_card_expiration_date = attributes[:credit_card_expiration_date] if attributes[:credit_card_expiration_date]
    @result = attributes[:result] if attributes[:result]
    if attributes.count > 0
      @updated_at = Time.now
    end
  end
end