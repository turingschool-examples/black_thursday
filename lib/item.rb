require 'bigdecimal'

class Item
  attr_accessor :id,
                :name,
                :description,
                :unit_price,
                :created_at,
                :updated_at,
                :merchant_id,
                :repo
  def initialize(item_info, repo)
    @id = item_info[:id].to_i
    @name = item_info[:name]
    @description = item_info[:description]
    @unit_price = BigDecimal((item_info[:unit_price].to_i / 100.to_f), 8)
    @created_at = Time.parse(item_info[:created_at].to_s)
    @updated_at = Time.parse(item_info[:updated_at].to_s)
    @merchant_id = item_info[:merchant_id].to_i
    @repo = repo
  end

  #check spec harness
  def unit_price_to_dollars
    @unit_price.to_f
  end
end
