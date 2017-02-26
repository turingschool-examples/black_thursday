require_relative 'merchant'
require_relative 'sales_engine'
require_relative 'item_repository'
require_relative 'item'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require 'pry'

class Invoice

    attr_reader :id,
                :customer_id,
                :merchant_id,
                :status,
                :created_at,
                :updated_at,
                :parent

  def initialize(data, parent)
    @id = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status = data[:status]
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
    @parent = parent
  end

  def merchant
    parent.find_merchant(merchant_id)
  end

end
