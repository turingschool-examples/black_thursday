class Item
  attr_reader   :id,
                :created_at,
                :merchant_id

  attr_accessor :name,
                :description,
                :unit_price,
                :updated_at

  def initialize(data)
    @id          = data[:id].to_i
    @name        = data[:name]
    @description = data[:description]
    @unit_price  = BigDecimal(data[:unit_price])
    @created_at  = data[:created_at]
    @updated_at  = data[:updated_at]
    @merchant_id = data[:merchant_id].to_i
  end

  def update(id, attributes)
    return @name = attributes[:name] if attributes[:name] != nil

    return @description = attributes[:description] if attributes[:description] != nil
    return @unit_price  = (attributes[:unit_price]) if attributes[:unit_price] != nil
    @updated_at = Time.now
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
