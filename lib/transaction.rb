require_relative 'require_store'

class Transaction
  attr_accessor :id,
                :invoice_id,
                :credit_card_number,
                :credit_card_expiration_date,
                :result,
                :created_at,
                :updated_at

  def initialize(data)
    @id = data[:id].to_i
    @invoice_id = data[:invoice_id].to_i
    @credit_card_number = data[:credit_card_number]
    @credit_card_expiration_date = data[:credit_card_expiration_date]
    @result = data[:result].to_sym
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
  end
end