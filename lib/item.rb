require 'time'
require 'bigdecimal'

class Item
  attr_reader :id,:name,:description,:unit_price, :merchant_id
  attr_reader :created_at, :updated_at

  def initialize(column, parent = nil)
    @id = column.fetch(:id).to_i
    @name = column.fetch(:name)
    @description = column.fetch(:description)
    @unit_price = BigDecimal(column.fetch(:unit_price).to_i)/BigDecimal(100)
    @created_at = Time.parse(column.fetch(:created_at))
    @updated_at = Time.parse(column.fetch(:updated_at))
    @merchant_id = column.fetch(:merchant_id).to_i
    @item_repo = parent
  end

  def unit_price_to_dollars
    dollar_price = sprintf('%.02f', @unit_price).to_f
  end

  def merchant
    id = self.merchant_id
    @item_repo.find_merchant_by_merch_id(id)
  end


end
