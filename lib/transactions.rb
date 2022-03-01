# Transaction class
require 'time'

class Transaction
  attr_accessor :invoice_id, :credit_card_number, :result, :unit_price, :updated_at
  attr_reader :id, :created_at, :merchant_id

  def initialize(attributes)
    @id = attributes[:id].to_i
    @invoice_id = attributes[invoice_id].to_i
    @credit_card_number = attributes[:credit_card_number]
    @cred_card_expiration_date = attributes[:cred_card_expiration_date]
    @result = attributes[:result]
    @created_at = Time.parse(attributes[:created_at].to_s)
    @updated_at = Time.parse(attributes[:updated_at].to_s)
  end
end
