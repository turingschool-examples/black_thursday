require 'requirements'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id

  def initialize(info, repo)
    @id = info[:id].to_i
    @name = info[:name]
    @description = info[:description]
    @unit_price = BigDecimal(info[:unit_price].to_f / 100, 7)
    @created_at = Time.parse(info[:created_at])
    @updated_at = Time.parse(info[:updated_at])
    @merchant_id = info[:merchant_id].to_i
    @repo = repo
  end

  def unit_price_to_dollars
    @unit_price.round(2).to_f
  end

  def update(attributes)
    @name = attributes[:name] if !attributes[:name].nil?
    @description = attributes[:description] if !attributes[:description].nil?
    @unit_price = attributes[:unit_price] if !attributes[:unit_price].nil?
    @updated_at = Time.now
  end
end