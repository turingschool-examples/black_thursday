class Transaction
  attr_reader   :id,
                :invoice_id,
                :created_at,
                :credit_card_number,
                :credit_card_expiration_date,
                :result,
                :updated_at

  def initialize(data)
    @id                           = data[:id].to_i
    @invoice_id                   = data[:invoice_id].to_i
    @credit_card_number           = data[:credit_card_number]
    @credit_card_expiration_date  = data[:credit_card_expiration_date]
    @result                       = data[:result].to_sym
    @created_at                   = Time.parse(data[:created_at])
    @updated_at                   = Time.parse(data[:updated_at])
  end

  def update_ccnum(cc_num)
    @credit_card_number = cc_num
  end

  def update_cc_expiration(cc_exp)
    @credit_card_expiration_date = cc_exp
  end

  def update_result(result)
    @result = result
  end

  def update_updated_at
    @updated_at = Time.now
  end
end
