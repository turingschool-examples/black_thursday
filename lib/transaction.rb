require 'time'

class Transaction
# create transaction objects
  attr_reader   :id,
                :invoice_id,
                :created_at
  attr_accessor :result,
                :credit_card_number,
                :credit_card_expiration_date,
                :updated_at

  def initialize(args)
    @id                          = args[:id].to_i
    @invoice_id                  = args[:invoice_id].to_i
    @credit_card_number          = args[:credit_card_number]
    @credit_card_expiration_date = args[:credit_card_expiration_date]
    @result                      = args[:result].to_sym
    @created_at                  = Time.parse(args[:created_at])
    @updated_at                  = Time.parse(args[:updated_at])
  end
end
