require 'time'
require 'bigdecimal'

class Transaction
  attr_accessor :id,
                :invoice_id,
                :credit_card_number,
                :credit_card_expiration_date,
                :result,
                :created_at,
                :updated_at


  def initialize(item_hash)
    @id = item_hash[:id]
    @invoice_id = item_hash[:invoice_id]
    @credit_card_number = item_hash[:credit_card_number]
    @credit_card_expiration_date = item_hash[:credit_card_expiration_date]
    @result = item_hash[:result]
    @created_at = (item_hash[:created_at])
    @updated_at = (item_hash[:updated_at])
  end
end
