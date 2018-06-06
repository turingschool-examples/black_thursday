require 'bigdecimal'
require 'time'

class Invoice
  attr_reader   :id,
                :customer_id,
                :merchant_id,
                :status,
                :created_at
  attr_accessor :updated_at

  def initialize(attributes)
    @id          = attributes[:id].to_i
    @customer_id = attributes[:customer_id].to_i
    @merchant_id = attributes[:merchant_id].to_i
    @status      = attributes[:status].to_sym
    @created_at  = Time.parse(attributes[:created_at].to_s)
    @updated_at  = Time.parse(attributes[:updated_at].to_s)
  end

  def update_status(attributes)
    @status = attributes[:status]
  end

  def update_updated_at(attributes)
    @updated_at = attributes
  end

  def day_of_week 
    @created_at.strftime("%A")
  end
end
