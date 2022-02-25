class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id

  def initialize(info_hash)
    @id          = info_hash[:id]
    @name        = info_hash[:name]
    @description = info_hash[:description]
    @unit_price  = info_hash[:unit_price]
    @created_at  = info_hash[:created_at]
    @updated_at  = info_hash[:updated_at]
    @merchant_id = info_hash[:merchant_id]
  end

  def unit_price_to_dollars
    unit_price.to_f.round(2)
  end

  def update(updated_info_hash)
    @name = updated_info_hash[:name] if updated_info_hash[:name]
    @description = updated_info_hash[:description] if updated_info_hash[:description]
    @unit_price = BigDecimal(updated_info_hash[:unit_price])  if updated_info_hash[:unit_price]
    @updated_at = Time.now.getutc
  end
end
