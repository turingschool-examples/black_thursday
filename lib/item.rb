require 'bigdecimal'
require 'time'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id

  attr_accessor :parent

  def initialize(row, parent =nil)
    @id           = row[:id].to_i
    @name         = row[:name]
    @description  = row[:description]
    @unit_price   = BigDecimal.new(row[:unit_price]) / 100
    @created_at   = Time.parse(row[:created_at])
    @updated_at   = Time.parse(row[:updated_at])
    @merchant_id  = row[:merchant_id].to_i
    @parent       = parent
  end

  def merchant
    parent.parent.merchants.find_by_id(self.merchant_id)
  end
end
