class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :merchant_id
  attr_accessor :updated_at

  def initialize(attributes)
    @id = attributes[:id].to_i
    @name = attributes[:name]
    @description = attributes[:description]
    @unit_price = attributes[:unit_price]
    @merchant_id = attributes[:merchant_id].to_i
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def update_name(attributes)
    @name = attributes[:name]
  end
  
end
