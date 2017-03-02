class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at

  def initialize(transaction, parent)
    @id = transaction[:id].to_i
    @invoice_id = transaction[:invoice_id].to_i
    @credit_card_number = transaction[:credit_card_number].to_i
    @credit_card_expiration_date = transaction[:credit_card_expiration_date]
    @result = transaction[:result].to_s
    @created_at = Time.parse(transaction[:created_at])
    @updated_at = Time.parse(transaction[:updated_at])
    @parent = parent
  end

def invoice  
  @parent.parent.invoices.find_by_id(@invoice_id)
end

end
