require 'bigdecimal'
require 'time'


class Item
 attr_reader :name,
             :id,
             :description,
             :unit_price,
             :created_at,
             :updated_at,
             :merchant_id

  def initialize(data)
   @id          = data[:id]
   @name        = data[:name]
   @description = data[:description]
   @unit_price  = BigDecimal.new(data[:unit_price].insert(-3, "."))
   @created_at  = Time.parse(data[:created_at])
   @updated_at  = Time.parse(data[:updated_at])
   @merchant_id = data[:merchant_id]
  end

  def unit_price_to_dollars
    unit_price.truncate.to_s + '.' + sprintf('%02d', (v.frac * 100).truncate)
  end

end
