require 'time'
require 'bigdecimal/util'
require 'bigdecimal'
class Transaction

  attr_accessor :unit_price
  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at

  def initialize (data, repository)
    @id                  = data[:id]
    @invoice_id          = data[:invoice_id]
    @credit_card_number  = data[:credit_card_number]
    @credit_card_expiration_date = data[:credit_card_expiration_date]
    @result              = data[:result]
    @created_at          = Time.parse(data[:created_at].to_s)
    @updated_at          = Time.parse(data[:updated_at].to_s)
    @repository          = repository
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def update_attributes (new_attributes)
    @credit_card_number  = data[:credit_card_number]
    @credit_card_expiration_date = data[:credit_card_expiration_date]
    @result = data[:result]
  end
end
