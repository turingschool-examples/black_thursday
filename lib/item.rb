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
    @created_at = data[:created_at]
    @description = data[:description]
    @id = data[:id]
    @name = data[:name]
    @merchant_id = data[:merchant_id]
    @unit_price = data[:unit_price]
    @updated_at = data[:updated_at]
  end

end
