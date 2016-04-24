require 'time'

class Transaction
  attr_reader :id, :invoice_id, :credit_card_number, :credit_card_expiration_date,
              :result, :created_at, :updated_at

  def initialize(column, parent = nil)
    @id = column[:id].to_i
    @invoice_id = column[:invoice_id].to_i
    @credit_card_number = column[:credit_card_number]
    @credit_card_expiration_date = column[:credit_card_expiration_date]
    @result = column[:result]   #.to_sym
    @created_at = Time.parse(column[:created_at])
    @updated_at = Time.parse(column[:updated_at])
    @transaction_repo = parent
  end
end
