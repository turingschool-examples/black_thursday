
class Item
  attr_reader :id, :name, :description, :unit_price,
              :created_at, :updated_at, :merchant_id

  def initialize(input_hash)
    @id = input_hash[:id]
    @name = input_hash[:name]
    @description = input_hash[:description]
    @unit_price = input_hash[:unit_price]
    @created_at = input_hash[:created_at]
    @updated_at = input_hash[:updated_at]
    @merchant_id = input_hash[:merchant_id]
  end

  def self.unit_price_to_dollars(unit_price)
    "$#{unit_price.to_f.round(2)}"
  end
end
