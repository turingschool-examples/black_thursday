require 'bigdecimal'
require 'date'
class Item
  attr_reader :id,
              :created_at,
              :updated_at,
              :merchant_id

  attr_accessor :name,
                :description,
                :unit_price

  def initialize(row, item_repo)
    @id = (row[:id]).to_i
    @name = row[:name]
    @description = row[:description]
    @unit_price = BigDecimal(row[:unit_price])
    @created_at = Time.parse(row[:created_at])
    @updated_at = Time.parse(row[:updated_at])
    @merchant_id = (row[:merchant_id]).to_i
    @item_repo = item_repo
  end

  def update
    @updated_at = Time.now
  end

  def format_unit_price
    @unit_price = BigDecimal(@unit_price)
  end
end
