require 'pry'

class Transaction
  attr_accessor :credit_card_number, :credit_card_expiration_date, :result, :updated_at
  attr_reader :id, :invoice_id, :created_at

  def initialize(info_hash)
    @id = info_hash[:id]
    @invoice_id = info_hash[:invoice_id]
    @credit_card_number = info_hash[:credit_card_number]
    @credit_card_expiration_date = info_hash[:credit_card_expiration_date]
    @result = info_hash[:result]
    @created_at = info_hash[:created_at]
    @updated_at = info_hash[:updated_at]
  end
end
