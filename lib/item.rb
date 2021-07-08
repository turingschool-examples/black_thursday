require 'bigdecimal'
require 'time'


class Item
  attr_reader   :id,
                :name,
                :description,
                :unit_price,
                :created_at,
                :updated_at,
                :merchant_id,
                :unit_price_to_dollars,
                :item_repository

  def initialize(attributes = {}, parent = nil)
    @id           = attributes[:id].to_i
    @name         = attributes[:name]
    @description  = attributes[:description]
    @unit_price   = BigDecimal.new(attributes[:unit_price].to_i/100.0, 4)
    @created_at   = Time.parse(attributes[:created_at])
    @updated_at   = Time.parse(attributes[:updated_at])
    @merchant_id  = attributes[:merchant_id].to_i
    @item_repository = parent
  end
  def unit_price_to_dollars
    unit_price / 100
  end

  def merchant
    @item_repository.find_merchant_by_id(merchant_id)
  end

end
