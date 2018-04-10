# frozen_string_literal: true

# class item takes a hash and has attribute readers for :name, :description, :unit_price, :created_at, :updated_at
class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at

  def initialize(data)
    @id = data[:id].to_i
    @name = data[:name]
    @description = data[:description]
    @merchant_id = data[:merchant_id].to_i
    @unit_price = BigDecimal.new(data[:unit_price])/100
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
    @unit_price_to_dollars = @unit_price.to_f
  end

end
