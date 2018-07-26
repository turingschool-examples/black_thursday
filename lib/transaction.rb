require 'bigdecimal'
require 'bigdecimal/util'
require 'time'

class Transaction
  attr_reader   :id,
                :invoice_id

  attr_accessor :credit_card_number,
                :credit_card_expiration_date,
                :result,
                :created_at,
                :updated_at

  def initialize(transaction_hash)
    @id = transaction_hash[:id].to_i
    @invoice_id = transaction_hash[:invoice_id].to_i
    @credit_card_number = transaction_hash[:credit_card_number].to_i
    @credit_card_expiration_date = transaction_hash[:credit_card_expiration_date].to_i
    @result = transaction_hash[:result].to_sym
    @created_at = Time.parse(transaction_hash[:created_at])
    @updated_at = Time.parse(transaction_hash[:updated_at])
  end
end
