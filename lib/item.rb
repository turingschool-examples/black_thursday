require 'bigdecimal'
require 'time'

class Item
    attr_reader :id, :name, :description, :unit_price, :created_at, :updated_at, :merchant_id

  def initialize(row, parent=nil)
    @id = row[:id].to_i
    @name = row[:name]
    @description = row[:description]
    @unit_price = BigDecimal.new(row[:unit_price])
    @created_at = Time.parse(row[:created_at])
    @updated_at = Time.parse(row[:updated_at])
    @merchant_id = row[:merchant_id].to_i
    @parent = parent
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

  # def created_at
  #   # returns a Time instance for the date the item was first created
  # end
  #
  # def updated_at
  #   # returns a Time instance for the date the item was last modified
  # end

  # def merchant_id
  #   # returns the integer merchant id of the item
  # end
end
