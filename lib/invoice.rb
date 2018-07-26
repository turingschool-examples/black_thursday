require 'bigdecimal'
require 'bigdecimal/util'
require 'time'

class Invoice
  attr_reader   :id,
                :customer_id,
                :merchant_id,
                :created_at
  attr_accessor :status,
                :updated_at

  def initialize(information)
    @id = information[:id].to_i
    @customer_id = information[:customer_id].to_i
    @merchant_id = information[:merchant_id].to_i
    @status = information[:status].to_sym
    @created_at = Time.parse(information[:created_at].to_s)
    @updated_at = Time.parse(information[:updated_at].to_s)
  end
end
