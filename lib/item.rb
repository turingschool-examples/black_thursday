require 'BigDecimal'
require 'time'

class Item
  attr_reader :id, :name, :description, :unit_price, :created_at, :updated_at, :merchant_id
  attr_writer :name, :description, :unit_price, :updated_at
  def initialize(info)
    @id = info[:id].to_i
    @name = info[:name]
    @description = info[:description]
    @unit_price = BigDecimal(info[:unit_price])/100
    @created_at = Time.parse(info[:created_at].to_s)
    @updated_at = Time.parse(info[:updated_at].to_s)
    @merchant_id = info[:merchant_id].to_i
  end

  def unit_price_to_dollars
    @unit_price.truncate(2).to_f
  end
end
