require_relative 'elementals'

# item class
class Item
  include Elementals

  attr_reader :id,
              :merchant_id,
              :created_at

  attr_accessor :name,
                :description,
                :unit_price,
                :updated_at

  def initialize(attrs)
    sigdigits    = attrs[:unit_price].to_s.length - 1
    @id          = attrs[:id].to_i
    @name        = attrs[:name]
    @description = attrs[:description]
    @unit_price  = BigDecimal(attrs[:unit_price], sigdigits) / 100
    @merchant_id = attrs[:merchant_id].to_i
    @created_at  = format_time(attrs[:created_at])
    @updated_at  = format_time(attrs[:updated_at])
  end

  def unit_price_to_dollars
    @unit_price = @unit_price.to_f.round(2)
  end
end
