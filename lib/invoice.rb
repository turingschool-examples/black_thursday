require_relative '../lib/item'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'
require 'bigdecimal'
require 'time'

class Invoice
  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at

  def initialize(attributes)
    @id = attributes[:id].to_i
    @customer_id = attributes[:customer_id]
    @merchant_id = attributes[:merchant_id]
    @status = attributes[:status]
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
  end

end
