require 'bigdecimal'
require 'date'
require 'time'
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
    @unit_price = BigDecimal(row[:unit_price]) / 100
    @created_at = Time.parse(row[:created_at].to_s)
    @updated_at = Time.parse(row[:updated_at].to_s)
    @merchant_id = (row[:merchant_id]).to_i
    @item_repo = item_repo
  end

  def update_time_stamp
    @updated_at = Time.now
  end

  def unit_price_to_big_decimal
    if @unit_price.class != BigDecimal
      @unit_price = BigDecimal(@unit_price) /100
    end
  end

  def unit_price_to_dollars
    @unit_price = @unit_price.to_f
  end
end
