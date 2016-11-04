require_relative '../lib/item_repository'
require 'bigdecimal'
require 'time'

class Item
  attr_reader   :name,
                :description,
                :unit_price,
                :created_at,
                :updated_at,
                :merchant_id,
                :id

  def initialize(item_data, parent = nil)
    @item_parent = parent
    @name        = item_data[:name]
    @id          = item_data[:id].to_i
    @description = item_data[:description]
    @unit_price  = find_unit_price(item_data[:unit_price])
    @created_at  = determine_the_time(item_data[:created_at])
    @updated_at  = determine_the_time(item_data[:updated_at])
    @merchant_id = item_data[:merchant_id].to_i
  end

  def merchant
    id_number = @item_parent.find_all_by_merchant_id(self.merchant_id)[0].merchant_id
    @item_parent.parent.merchants.find_by_id(id_number)
  end

  def find_unit_price(price)
    if unit_price == ""
      unit_price = BigDecimal.new(0)
    else
      unit_price = BigDecimal.new(price) / 100
    end
    return unit_price
  end

  def unit_price_to_dollars(unit_price)
    @unit_price.to_f
  end

  def determine_the_time(time_string)
    time = Time.new(0)
    return time if time_string == ""
    time_string = Time.parse(time_string)
  end

end
