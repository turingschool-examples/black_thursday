require 'time'

class Transaction
  attr_reader :id, :invoice_id, :result, :created_at, :updated_at
  attr_accessor :updated_at, :credit_card_number, :credit_card_expiration_date

  def initialize(attributes)
    @id                           = attributes[:id]
    @invoice_id                   = attributes[:invoice_id]
    @credit_card_number           = attributes[:credit_card_number]
    @credit_card_expiration_date  = attributes[:credit_card_expiration_date]
    @result                       = attributes[:result]
    @created_at                   = attributes[:created_at]
    @updated_at                   = attributes[:updated_at]
  end

  
end
