require 'pry'
require 'time'
require 'bigdecimal'

class Item

  attr_reader     :item_hash,
                  :id,
                  :name,
                  :description,
                  :unit_price,
                  :created_at,
                  :updated_at,
                  :merchant_id

  def initialize(item_hash)
    @item_hash = item_hash
    @id = item_hash[:id].to_i 
    @name = item_hash[:name]
    @description = item_hash[:description]
    @unit_price = BigDecimal(item_hash[:unit_price])/100
    @created_at = Time.parse(item_hash[:created_at].to_s) 
    @updated_at = Time.parse(item_hash[:updated_at].to_s)
    @merchant_id = item_hash[:merchant_id].to_i
  end
  
  def unit_price_to_dollars 
    unit_price.to_f 
  end 

  def convert_to_dollar_string
    "$#{unit_price_to_dollars}"
  end

  def update_attributes(attributes)
    @name = attributes[:name] || @name
    @description = attributes[:description] || @description
    @unit_price = attributes[:unit_price] || @unit_price
    @updated_at = Time.now
  end
end
