require './lib/finder'

class Transaction
  include Finder

  attr_reader :id,
              :invoice_id,
              :created_at,
              :updated_at

  attr_accessor :credit_card_number,
                :credit_card_expiration_date,
                :result
              

  def initialize(hash)
    @id = hash[:id]
    @invoice_id = hash[:invoice_id]
    @credit_card_number = hash[:credit_card_number]
    @credit_card_expiration_date = hash[:credit_card_expiration_date]
    @result = hash[:result]
    @created_at = hash[:created_at]
    @updated_at = hash[:updated_at]
  end


end