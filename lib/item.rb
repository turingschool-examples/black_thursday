require_relative 'require_store'

class Item
  attr_accessor :id, :name, :description, :unit_price, :created_at, :updated_at, :merchant_id
  def initialize(data)
    @id = data[:id].to_i
    @name = data[:name]
    @description = data[:description]
    @unit_price = data[:unit_price].to_d / 100
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
    @merchant_id = data[:merchant_id].to_i
  end

  def unit_price_to_dollars
    unit_price.to_f
  end
end