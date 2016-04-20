require 'bigdecimal'

class Item
  attr_reader :id,:name,:description,:unit_price, :merchant_id
  attr_reader :created_at, :updated_at

  def initialize(column, parent)
    @id = column.fetch(:id).to_i
    @name = column.fetch(:name)
    @description = column.fetch(:description)
    @unit_price = column.fetch(:unit_price)
    @created_at = column.fetch(:created_at)
    @updated_at = column.fetch(:updated_at)
    @merchant_id = column.fetch(:merchant_id).to_i
    @item_repo = parent
  end

  def unit_price_to_dollars
    dollar_price = @unit_price.to_f
  end

  def merchant
    @item_repo.find_merchant_by_merch_id(merchant_id)
  end


end
