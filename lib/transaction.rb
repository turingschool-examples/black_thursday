class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at
  def initialize(data, tr = nil)
    @tr                           = tr
    @id                           = data[:id].to_i
    @invoice_id                   = data[:invoice_id].to_i
    @credit_card_number           = data[:credit_card_number].to_i
    @credit_card_expiration_date  = data[:credit_card_expiration_date].to_s
    @result                       = data[:result].to_s
    @created_at                   = Time.parse(data[:created_at])
    @updated_at                   = Time.parse(data[:updated_at])
  end

  def invoice
    @tr.fetch_invoice_id_from_transactions(invoice_id)
  end
end
