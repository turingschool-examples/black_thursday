class Transaction

  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at

  def initialize(row, parent = nil)
    @id = row[:id].to_i
    @invoice_id = row[:invoice_id].to_i
    @credit_card_number = row[:credit_card_number].to_i
    @credit_card_expiration_date = row[:credit_card_expiration_date]
    @result = row[:result]
    @created_at = row[:created_at].nil?? Time.now : Time.parse(row[:created_at])
    @updated_at = row[:updated_at].nil?? Time.now : Time.parse(row[:updated_at])
    @parent = parent
  end

  def invoice
    @parent.find_invoice_by_id(self.invoice_id)
  end
end
