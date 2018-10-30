require 'time'

class Transaction
  attr_reader :id,
              :invoice_id,
              :created_at
  attr_accessor :updated_at,
                :credit_card_number,
                :credit_card_expiration_date,
                :result

  def initialize(transaction_hash)
    @id = transaction_hash[:id].to_i
    @invoice_id = transaction_hash[:invoice_id].to_i
    @credit_card_number = transaction_hash[:credit_card_number]
    @credit_card_expiration_date = transaction_hash[:credit_card_expiration_date]
    @result = transaction_hash[:result].to_sym
    @created_at = Time.parse(transaction_hash[:created_at])
    @updated_at = Time.parse(transaction_hash[:updated_at])
  end
end
