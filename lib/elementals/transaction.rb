require_relative 'elementals'

# transaction class
class Transaction
  include Elementals

  attr_reader :id,
              :invoice_id,
              :created_at

  attr_accessor :credit_card_number,
                :credit_card_expiration_date,
                :result,
                :updated_at

  def initialize(attrs)
    @id = attrs[:id].to_i
    @invoice_id = attrs[:invoice_id].to_i
    @credit_card_number = attrs[:credit_card_number]
    @credit_card_expiration_date = attrs[:credit_card_expiration_date]
    @result      = attrs[:result].to_sym
    @created_at  = format_time(attrs[:created_at])
    @updated_at  = format_time(attrs[:updated_at])
  end
end
