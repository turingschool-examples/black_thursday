require_relative '../lib/item_repository'
require 'bigdecimal'


class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :unit_price_to_dollars

  def initialize(item_data)
  @id = item_data[:id]
  @name = item_data[:name]
  @description = item_data[:description]
  @unit_price = item_data[:unit_price]
  @merchant_id = item_data[:merchant_id]
  end

  def unit_price_to_dollars
    '%.02f' % (unit_price.to_f)
  end

end
