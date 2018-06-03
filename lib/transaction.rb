class Transaction
  attr_accessor :credit_card_number,
                :credit_card_expiration_date,
                :result,
                :updated_at
  attr_reader   :id,
                :invoice_id,
                :created_at

  def initialize(attributes)
    @id = attributes[:id].to_i
    @invoice_id = attributes[:invoice_id].to_i
    @credit_card_number = attributes[:credit_card_number]
    @credit_card_expiration_date = attributes[:credit_card_expiration_date]
    @result = attributes[:result].to_sym
    @created_at = Time.parse(attributes[:created_at])
    @updated_at = Time.parse(attributes[:updated_at])
  end
end
