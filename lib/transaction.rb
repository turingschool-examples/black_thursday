require 'pry'

require_relative 'data_typing'

class Transaction
  include DataTyping

  attr_reader :id,
              :invoice_id,
              :created_at


  attr_accessor :credit_card_number,
                :credit_card_expiration_date,
                :result,
                :updated_at

  def initialize(hash)
    # -- Read Only --
    @id                 = make_integer(hash[:id])
    @invoice_id         = make_integer(hash[:invoice_id])
    @created_at         = make_time(hash[:created_at])
    # -- Accessible --
    @credit_card_number = hash[:credit_card_number]
    @credit_card_expiration_date = hash[:credit_card_expiration_date]
    @result             = make_symbol(hash[:result])
    @updated_at         = make_time(hash[:updated_at])
  end

  def make_updates(hash)
    @credit_card_number = hash[:credit_card_number] if hash[:credit_card_number]
    card_date = hash[:credit_card_expiration_date]
    @credit_card_expiration_date = card_date        if card_date
    @result = make_symbol(hash[:result])            if hash[:result]
    @updated_at  = make_time(hash[:updated_at])     if hash[:updated_at]
    @updated_at  = make_time(Time.now)              if hash[:updated_at] == nil
  end



end
