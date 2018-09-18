require 'pry'

require_relative 'data_typing'

class Transaction
  include DataTyping

  attr_reader :id,
              :invoice_id,
              :created_at,
              :updated_at

  attr_accessor :credit_card_number,
                :credit_card_expiration_date,
                :result

  def initialize(hash)
    # -- Read Only --
    @id                 = make_integer(hash[:id])
    @invoice_id         = make_integer(hash[:invoice_id])
    @created_at         = make_time(hash[:created_at])
    @updated_at         = make_time(hash[:updated_at])
    # -- Accessible --
    @credit_card_number = hash[:credit_card_number]
    @credit_card_expiration_date = hash[:credit_card_expiration_date]
    @result             = make_symbol(hash[:result])
  end
  
end
