require 'bigdecimal'
require 'time'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at

  def initialize(info, item_repository = "")
    #change updated_at and created_at
    @id = info[:id].to_i
    @name = info[:name]
    @description = info[:description]
    @unit_price = BigDecimal(info[:unit_price])
    @merchant_id = info[:merchant_id].to_i
    @created_at = Time.strptime(info[:created_at],"%Y-%m-%d %H:%M:%S %Z")
    @updated_at = Time.strptime(info[:updated_at],"%Y-%m-%d %H:%M:%S %Z")
    @parent = item_repository
  end

  def unit_price_to_dollars
    (@unit_price/100).to_f
  end

  def merchant
    @parent.find_merchant_by_id(@merchant_id.to_i)
  end

  def downcaser
    @name.downcase
  end

end
