require 'time'

class Invoice
  attr_reader :customer_id,
              :merchant_id
              
  attr_accessor :id,
                :created_at,
                :updated_at,
                :status

  def initialize(attributes)
    @id           = attributes[:id].to_i
    @customer_id  = attributes[:customer_id].to_i
    @merchant_id  = attributes[:merchant_id].to_i
    @status       = attributes[:status]
    @created_at   = time_converter(attributes[:created_at])
    @updated_at   = time_converter(attributes[:updated_at])
  end

  def time_converter(attributes)
    return unless attributes
    Time.parse(attributes)
  end
end
