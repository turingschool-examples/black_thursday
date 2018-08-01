class Transaction

  attr_reader     :id,
                  :invoice_id,
                  :created_at

  attr_accessor   :credit_card_number,
                  :credit_card_expiration_date,
                  :result,
                  :updated_at

  def initialize(info)
    @id = info[:id].to_i
    @invoice_id = info[:invoice_id].to_i
    @credit_card_number = info[:credit_card_number]
    @credit_card_expiration_date = info[:credit_card_expiration_date]
    @result = info[:result].to_sym
    @created_at = Time.parse(info[:created_at].to_s)
    @updated_at = Time.parse(info[:updated_at].to_s)
  end
end
