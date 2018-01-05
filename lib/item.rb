require 'bigdecimal'
require 'time'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id

  def initialize(data, parent)
    @id = data[:id]
    @name = data[:name]
    @description = data[:description]
    @unit_price = BigDecimal.new(data[:unit_price], 4) / 100
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
    @merchant_id = data[:merchant_id]
    @item_repository = parent
  end

  def unit_price_in_dollars
    @unit_price.to_f.round(2)
  end

  def merchant
    @item_repository.find_merchant_by_merchant_id(@merchant_id)
  end
end
