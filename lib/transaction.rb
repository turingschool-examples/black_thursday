require 'csv'
require 'time'

class Transaction
  attr_accessor :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at

  def initialize(data_hash)
    @id = data_hash[:id]
    @invoice_id = data_hash[:invoice_id]
    @credit_card_number = data_hash[:credit_card_number]
    @credit_card_expiration_date = data_hash[:credit_card_expiration_date]
    @result = data_hash[:result]
    @created_at = Time.parse(data_hash[:created_at])
    @updated_at = Time.parse(data_hash[:updated_at])
  end
end
