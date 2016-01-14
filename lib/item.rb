require 'pry'


class Item
  attr_reader :name, :id, :description, :unit_price, :created_at, :updated_at, :merchant_id

  def initialize(item_info)
    @name        = item_info[:name]
    @id          = item_info[:id]
    @description = item_info[:description]
    @unit_price  = item_info[:unit_price]
    @created_at  = item_info[:created_at]
    @updated_at  = item_info[:updated_at]
    @merchant_id = item_info[:merchant_id]
  end

end
