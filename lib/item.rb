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

  def update(attributes)
    update_name(attributes)
    update_description(attributes)
    update_unit_price(attributes)
    update_time_stamp
  end

  def update_name(attributes)
    return nil if attributes[:name] == nil
    @name = attributes[:name]
  end

  def update_description(attributes)
    return nil if attributes[:description] == nil
    @description = attributes[:description]
  end

  def update_unit_price(attributes)
    return nil if attributes[:unit_price] == nil
    @unit_price = attributes[:unit_price]
    unit_price_to_big_decimal
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
