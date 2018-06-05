require 'bigdecimal'
require 'time'

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
    @unit_price = BigDecimal(attributes[:unit_price].to_s)/100
    @merchant_id = attributes[:merchant_id].to_i
    @created_at = Time.parse(attributes[:created_at].to_s)
    @updated_at = Time.parse(attributes[:updated_at].to_s)
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def update_name(attributes)
    @name = attributes[:name]
  end

  def update_description(attributes)
    @description = attributes[:description]
  end

  def update_unit_price(attributes)
    @unit_price = BigDecimal(attributes[:unit_price].to_s)
  end

  def update_created_at(attributes)
    @created_at = Time.parse(attributes[:created_at].to_s)
  end

  def update_updated_at(attributes)
    @updated_at = attributes
  end
end
