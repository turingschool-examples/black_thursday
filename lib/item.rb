require 'bigdecimal'
require 'time'
require 'pry'

class Item

  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id,
              :item_repo

  def initialize(data, parent = nil)
    @id           = data[:id].to_i
    @name         = data[:name]
    @description  = data[:description]
    @unit_price   = BigDecimal.new(data[:unit_price], 4) / 100
    @created_at   = Time.parse(data[:created_at])
    @updated_at   = Time.parse(data[:updated_at])
    @merchant_id  = data[:merchant_id].to_i
    @item_repo    = parent
  end

  def unit_price_to_dollars
    "$#{unit_price.to_f}"
  end

  def merchant
    item_repo.find_merchant_by_merchant_id(merchant_id)
  end

end
