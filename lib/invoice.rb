# require 'bigdecimal'
# require 'bigdecimal/util'


class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :parent

  def initialize(args, parent)
    @id          = args[:id].to_i
    @customer_id = args[:customer_id].to_i
    @merchant_id = args[:merchant_id].to_i
    @status      = args[:status].to_sym
    @created_at  = Time.parse(args[:created_at].to_s)
    @updated_at  = Time.parse(args[:updated_at].to_s)
    @parent      = parent
  end
end
