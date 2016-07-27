require 'bigdecimal'
class Item
  attr_reader :name,
              :id,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id
  def initialize(input_item, parent = nil)
    @parent = parent
    @id = input_item[:id].to_i
    @name = input_item[:name]
    @description = input_item[:description]
    @unit_price = BigDecimal.new(input_item[:unit_price].to_f,4)
    @created_at = convert_string_to_time(input_item[:created_at]) || Time.now
    @updated_at = convert_string_to_time(input_item[:updated_at]) || Time.now
    @merchant_id = input_item[:merchant_id].to_i
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  #convert time to time by using Time.new(formatted list of strings)
  def convert_string_to_time(time_input)
    return Time.now if time_input == nil
    Time.strptime(time_input, "%Y-%m-%d %H:%M:%S %z")
  end

  def merchant
    @parent.find_merchant_by_item_id(self.merchant_id)
  end
end
