require 'bigdecimal'
require 'time'
class Item
  attr_reader :created_at,
              :merchant_id
              :repo
  attr_accessor :id,
                :name,
                :description,
                :unit_price,
                :updated_at

  def initialize(attributes, repo = nil)
    @id = attributes[:id].to_i
    @name = attributes[:name]
    @description = attributes[:description]
    @unit_price = BigDecimal(attributes[:unit_price], 4) / 100
    @created_at = Time.parse(attributes[:created_at])
    @updated_at = Time.parse(attributes[:updated_at])
    @merchant_id = attributes[:merchant_id].to_i
    @repo = repo
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  # def merchant
  #   @repo
  # end
end
