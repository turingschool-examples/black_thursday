require 'bigdecimal'
require 'time'

class Item
  attr_reader :id,
              :name,
              :updated_at,
              :description,
              :unit_price,
              :created_at,
              :merchant_id,
              :merchant,
              :repo


  def initialize(row, repo)
    @id = row[:id].to_i
    @name = row[:name]
    @description = row[:description]
    @unit_price = unit_price_to_dollars(row[:unit_price])
    @updated_at = Time.parse(row[:updated_at])
    @created_at = Time.parse(row[:created_at])
    @merchant_id = row[:merchant_id].to_i
    @repo = repo
  end

  def unit_price_to_dollars(price)
    BigDecimal.new(price) / 100
  end

  def merchant
    repo.sales_engine.merchants.find_by_id(self.merchant_id)
  end

end
