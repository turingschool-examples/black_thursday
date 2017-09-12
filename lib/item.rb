require 'time'
require 'bigdecimal'
require 'csv'

class Item
  attr_accessor :id, :name, :description, :unit_price, :created_at, :updated_at,
    :merchant_id

  def initialize(item = {})
    @id = item.fetch(:id).to_i
    @name = item.fetch(:name)
    @description = item.fetch(:description)
    @unit_price = BigDecimal.new(item.fetch(:unit_price))
    @created_at = Time.parse(item.fetch(:created_at))
    @updated_at = Time.parse(item.fetch(:updated_at))
    @merchant_id = item.fetch(:merchant_id).to_i
  end

  def unit_to_dollar(unit_price = @unit_price)
    price = unit_price.to_f.to_s
    "$#{price}"
  end

end
