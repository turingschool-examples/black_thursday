require 'time'
require 'bigdecimal'
require 'pry'

class Item
  attr_reader :id, :name, :description, :unit_price, :merchant_id,
              :created_at, :updated_at, :item_repo

  def initialize(column, parent = nil)
    @id = column[:id].to_i
    @name = column[:name]
    @description = column[:description]
    @unit_price = BigDecimal(column[:unit_price].to_i)/BigDecimal(100)
    @created_at = Time.parse(column[:created_at])
    @updated_at = Time.parse(column[:updated_at])
    @merchant_id = column[:merchant_id].to_i
    @item_repo = parent
  end

  def unit_price_to_dollars
    dollar_price = sprintf('%.02f', unit_price).to_f
  end

  def merchant
    id = self.merchant_id
    item_repo.find_merchant_by_merch_id(id)
  end
end
