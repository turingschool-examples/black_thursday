
class Item
attr_reader  :created_at,
              :merchant_id
attr_accessor :id,
              :updated_at,
              :name,
              :description,
              :unit_price

  def initialize(info_hash)
    @id = info_hash[:id].to_i
    @name = info_hash[:name]
    @description = info_hash[:description]
    @unit_price = info_hash[:unit_price].to_d
    @created_at = info_hash[:created_at]
    @updated_at = info_hash[:updated_at]
    @merchant_id = info_hash[:merchant_id].to_i
  end

  def unit_price_to_dollars
    (@unit_price / 100).round(2)
  end

end
