require 'bigdecimal'

class Item
  attr_reader :id,:name,:description,:merchant_id,:unit_price
  attr_reader :created_at, :updated_at

  def initialize(column, parent)
    puts "WOOOOOOOOO"
    @id = column.fetch(:id)
    @name = column.fetch(:name)
    @description = column.fetch(:description)
    @unit_price = column.fetch(:unit_price)
    @created_at = column.fetch(:created_at)
    @updated_at = column.fetch(:updated_at)
    @merchant_id = column.fetch(:merchant_id)
    @item_repo = parent
  end

  def unit_price_to_dollars
    dollar_price = @unit_price.to_f
  end

end
