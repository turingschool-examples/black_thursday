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

  def initialize(item_data, item_repo)
    @item_data   = item_data
    @item_repo   = item_repo
    @id          = item_data[:id].to_i
    @name        = item_data[:name]
    @description = item_data[:description]
    @unit_price  = unit_price_to_dollars
    @created_at  = Time.parse(item_data[:created_at].to_s)
    @updated_at  = Time.parse(item_data[:updated_at].to_s)
    @merchant_id = item_data[:merchant_id].to_i
  end

  def unit_price_to_dollars
    var = BigDecimal.new(@item_data[:unit_price])
    var/100
  end

  def merchant
    @item_repo.sales_engine.merchants.find_by_id(@merchant_id)
  end

end
