require_relative '../lib/item'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'
require 'bigdecimal'
require 'time'

class Invoice
  attr_accessor :id, :customer_id, :merchant_id, :status, :created_at, :updated_at

  def initialize(attributes)
    @id = attributes[:id].to_i
    @customer_id = attributes[:customer_id].to_i
    @merchant_id = attributes[:merchant_id].to_i
    @status = attributes[:status].to_sym
    @created_at = if attributes[:created_at].class == Time
                    attributes[:created_at]
                  else
                    Time.parse(attributes[:created_at])
                  end
    @updated_at = if attributes[:updated_at].class == Time
                    attributes[:updated_at]
                  else
                    Time.parse(attributes[:updated_at])
                  end
  end

end
