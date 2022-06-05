require 'bigdecimal'
class Item
attr_accessor :id,
              :name,
              :description,
              :created_at,
              :updated_at,
              :unit_price,
              :merchant_id

  def initialize(data_hash)
    @id = data_hash[:id].to_i
    @name = data_hash[:name]
    @description = data_hash[:description]
    @created_at = data_hash[:created_at]
    @updated_at = data_hash[:updated_at]
    @unit_price = BigDecimal(data_hash[:unit_price],4)
    @merchant_id = data_hash[:merchant_id].to_i
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
