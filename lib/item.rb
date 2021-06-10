require 'bigdecimal'
require 'time'

class Item
  attr_reader  :id,
               :name,
               :description,
               :unit_price,
               :updated_at,
               :created_at,
               :merchant_id,
               :repo

  def initialize(info, repo)
    @id = info[:id].to_i
    @name = info[:name]
    @description = info[:description]
    @unit_price = (BigDecimal(info[:unit_price], 4) / 100)
    @created_at = info[:created_at].is_a?(Time) ? info[:created_at] : Time.parse(info[:created_at])
    @updated_at = info[:updated_at].is_a?(Time) ? info[:updated_at] : Time.parse(info[:updated_at])
    @merchant_id = info[:merchant_id].to_i
    @repo = repo
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def update_item(attributes)
    @name = attributes[:name] unless attributes[:name].nil?
    @description = attributes[:description] unless attributes[:description].nil?
    @unit_price = attributes[:unit_price] unless attributes[:unit_price].nil?
    @updated_at = Time.now
  end
end
