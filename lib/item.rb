require 'bigdecimal'
require 'csv'
require_relative '../lib/item_repo'
require 'time'

class Item
  attr_reader :parent,
              :id,
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
      @unit_price = BigDecimal.new(data[:unit_price].to_i)/BigDecimal.new(100)
      @merchant_id = data[:merchant_id].to_i
      @created_at = data[:created_at]
      @updated_at = data[:updated_at]
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def created_at
    Time.parse(@created_at)
  end

  def updated_at
    Time.parse(@updated_at)
  end

  def merchant
    @parent.find_merchant_for_item(merchant_id)
  end

end


