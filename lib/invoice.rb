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
  @customer_id = attributes[:customer_id]
  @merchant_id = attributes[:merchant_id].to_i
  @status      = attributes[:status]
  @created_at  = Time.parse(attributes[:created_at].to_s)
  @updated_at  = Time.parse(attributes[:updated_at].to_s)
end
