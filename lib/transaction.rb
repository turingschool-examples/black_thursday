require_relative 'business_data'

class Transaction < BusinessData
  attr_reader :id, :invoice_id, :created_at
  attr_accessor :credit_card_number, :credit_card_expiration_date,
                :result, :updated_at

  def initialize(input_hash)
    @id = input_hash[:id]
    @invoice_id = input_hash[:invoice_id]
    @credit_card_number = input_hash[:credit_card_number]
    @credit_card_expiration_date = input_hash[:credit_card_expiration_date]
    @result = input_hash[:result]
    @created_at= input_hash[:created_at]
    @updated_at = input_hash[:updated_at]
  end
end
