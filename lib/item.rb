class Item

  attr_reader :id, :name, :description, :unit_price, :created_at, :updated_at,
              :merchant_id

  def initialize(hash)
    @id = hash[:id].to_i
    @name = hash[:name]
    @description = hash[:description]
    @unit_price = hash[:unit_price]
    @created_at = Time.parse(hash[:created_at])
    @updated_at = Time.parse(hash[:updated_at])
    @merchant_id = hash[:merchant_id].to_i
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
  
end
