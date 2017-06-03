require "bigdecimal"
require "time"
require "pry"

class Item
  attr_reader :name,
              :id,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id,
              :repository

  def initialize(data, repository)
    @id = data[:id].to_i
    @name = data[:name]
    @description = data[:description]
    @unit_price = (BigDecimal.new(((data[:unit_price].to_i)/100.0), 0)).round(2)
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
    @merchant_id = data[:merchant_id].to_i
    @repository = repository
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

  def merchant
    repository.merchant_by_item(merchant_id)
  end
end
