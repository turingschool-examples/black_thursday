require_relative 'entry'
class Transaction
  attr_reader :id, :invoice_id, :created_at

  attr_accessor :credit_card_number,
                :credit_card_expiration_date,
                :result,
                :updated_at

  def initialize(details)
    @id = details[:id]
    @invoice_id = details[:invoice_id]
    @credit_card_number = details[:credit_card_number]
    @credit_card_expiration_date = details[:credit_card_expiration_date]
    @result = details[:result]
    @created_at = details[:created_at]
    @updated_at = details[:updated_at]
  end
end
