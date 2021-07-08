require 'bigdecimal'
require 'time'

class Transaction
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at

  def initialize(attributes = {}, parent = nil)
    @id                          = attributes[:id].to_i
    @invoice_id                  = attributes[:invoice_id].to_i
    @credit_card_number          = attributes[:credit_card_number].to_i
    @credit_card_expiration_date = attributes[:credit_card_expiration_date]
    @result                      = attributes[:result]
    @created_at                  = Time.parse(attributes[:created_at])
    @updated_at                  = Time.parse(attributes[:updated_at])
    @transaction_repo            = parent
  end

  def invoice
    @transaction_repo.find_by_invoice_id(invoice_id)
  end

end
