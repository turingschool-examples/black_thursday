require 'bigdecimal'
require 'time'

class Item
  attr_accessor :id,
                :name,
                :description,
                :unit_price,
                :created_at,
                :updated_at,
                :merchant_id

  def initialize(attributes, repository)
    @id = attributes[:id].to_i
    @name = attributes[:name]
    @description = attributes[:description]
    @unit_price = (BigDecimal(attributes[:unit_price])/100)
    @created_at = Time.parse(attributes[:created_at].to_s)
    @updated_at = Time.parse(attributes[:updated_at].to_s)
    @merchant_id = attributes[:merchant_id].to_i
    @repository = repository
  end

  def merchants(id)
    @repository.find_merchant_by_id(@merchant_id)
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
