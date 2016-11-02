require 'bigdecimal'
require 'csv'
require './lib/item_repo'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at

  def initialize(data, repo)
      @parent = repo
      @id = data[:id].to_i
      @name = data[:name]
      @description = data[:description]
      @unit_price = BigDecimal.new(data[:unit_price], 4).to_i
      @merchant_id = data[:merchant_id]
      @created_at = data[:created_at]
      @updated_at = data[:updated_at]
  end

  def unit_price_to_dollars
    @unit_price.to_f
    #returns the price as a float
  end
end


