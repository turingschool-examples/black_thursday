# frozen_string_literal: true

require 'BigDecimal'

class Item
  attr_accessor  :id,
                 :name,
                 :description,
                 :unit_price,
                 :created_at,
                 :updated_at,
                 :merchant_id

  def initialize(item)
    @id = item[:id].to_i
    @name = item[:name]
    @description = item[:description]
    @unit_price = BigDecimal(item[:unit_price].to_i) / 100
    @created_at = Time.parse(item[:created_at])
    @updated_at = Time.parse(item[:updated_at])
    @merchant_id = item[:merchant_id].to_i
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

  def update(attributes)
    current_time = Time.now
    attributes.each do |key, value|
      @description = value if key == :description
      @unit_price = value if key == :unit_price
      @name = value if key == :name
      @updated_at = current_time
    end
    self
  end
end
