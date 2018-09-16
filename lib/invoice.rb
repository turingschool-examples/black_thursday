require 'pry'

class Invoice

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :created_at,
              :updated_at

  attr_accessor :status

  def initialize(hash)
    @id          = hash[:id].to_i
    @customer_id = hash[:customer_id].to_i
    @merchant_id = hash[:merchant_id].to_i
    @status      = hash[:status].to_sym  # TO DO - TEST ME
    @created_at  = hash[:created_at]
    @updated_at  = hash[:updated_at]
  end

end
