require 'pry'

require_relative 'data_typing'

class Invoice
  include DataTyping

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :created_at,
              :updated_at

  attr_accessor :status

  def initialize(hash)
    @id          = make_integer(hash[:id])
    @customer_id = make_integer(hash[:customer_id])
    @merchant_id = make_integer(hash[:merchant_id])
    @status      = make_symbol(hash[:status])
    @created_at  = make_date(hash[:created_at])
    @updated_at  = make_date(hash[:updated_at])
  end

end
