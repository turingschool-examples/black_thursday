require 'pry'

require_relative 'data_typing'

class Invoice
  include DataTyping

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :created_at

  attr_accessor :status,
                :updated_at

  def initialize(hash)
    @id          = make_integer(hash[:id])
    @customer_id = make_integer(hash[:customer_id])
    @merchant_id = make_integer(hash[:merchant_id])
    @status      = make_symbol(hash[:status])
    # @created_at  = make_date(hash[:created_at])
    # @updated_at  = make_date(hash[:updated_at])
    # WHY make these times when they come in as just dates ?
    @created_at  = make_time(hash[:created_at])
    @updated_at  = make_time(hash[:updated_at])
  end

  def make_updates(hash)
    @status = make_symbol(hash[:status])        if hash[:status]
    # @updated_at  = make_time(hash[:updated_at]) if hash[:updated_at]
    # @updated_at  = make_time(Time.now)          if hash[:updated_at] == nil
    @updated_at  = make_time(hash[:updated_at]) if hash[:updated_at]
    @updated_at  = make_time(Time.now)          if hash[:updated_at] == nil
  end


end
