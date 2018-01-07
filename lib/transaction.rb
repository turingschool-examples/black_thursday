require 'bigdecimal'

class Transaction
  attr_reader   :id,
                :invoice_id,
                :credit_card_number,
                :credit_card_expiration_date,
                :result,
                :created_at,
                :updated_at

  def initialize(info, transaction_repository = "")
    @id = info[:id].to_i
    @invoice_id = info[:invoice_id].to_i
    @credit_card_number = BigDecimal.new(info[:credit_card_number], 16).to_i
    @credit_card_expiration_date = info[:credit_card_expiration_date].to_s.rjust(4,"0")
    @result = info[:result].to_s
    @created_at = Time.strptime(info[:created_at],"%Y-%m-%d %H:%M:%S %Z")
    @updated_at = Time.strptime(info[:updated_at],"%Y-%m-%d %H:%M:%S %Z")
    @parent = transaction_repository
  end

  def invoice
    @parent.find_invoice_by_invoice_id(@invoice_id)
  end
end
