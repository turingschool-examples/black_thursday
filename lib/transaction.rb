class Transaction

  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at,
              :parent_repo

  def initialize(datum, parent_repo = nil)
    @id = datum[:id].to_i
    @invoice_id = datum[:invoice_id].to_i
    @credit_card_number = datum[:credit_card_number]
    @credit_card_expiration_date = datum[:credit_card_expiration_date]
    @result = datum[:result].to_s.to_sym
    @created_at = Time.parse(datum[:created_at])
    @updated_at = Time.parse(datum[:updated_at])
    @parent_repo = parent_repo
  end

  def invoice
    parent_repo.find_invoice(invoice_id)
  end

end
