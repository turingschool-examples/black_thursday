require_relative './time_formatter'
require 'bigdecimal'

class Item
  include TimeFormatter
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id

  def initialize(item_data, parent = nil)
    @id          = item_data[:id].to_i
    @name        = item_data[:name]
    @description = item_data[:description]
    @unit_price  = BigDecimal(item_data[:unit_price].to_f / 100.0, 4)
    @created_at  = format_time(item_data[:created_at].to_s)
    @updated_at  = format_time(item_data[:updated_at].to_s)
    @merchant_id = item_data[:merchant_id].to_i
    @parent      = parent
  end

  def merchant
    @parent.find_merchant_by_merchant_id(merchant_id)
  end
end
