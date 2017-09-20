require 'time'

class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at,
              :parent

  def initialize(transaction, repo=nil)
    @id = transaction[:id].to_i
    @invoice_id = transaction[:invoice_id].to_i
    @credit_card_number = transaction[:credit_card_number].to_i
    @credit_card_expiration_date = transaction[:credit_card_expiration_date]
    @result = transaction[:result]
    @created_at = Time.parse(transaction[:created_at].to_s)
    @updated_at = Time.parse(transaction[:updated_at].to_s)
    @parent = repo
  end

  def invoice
    parent.transaction_invoice(invoice_id)
  end

end
