# frozen_string_literal: true

# class item takes a hash and has attribute readers for :name, :description, :unit_price, :created_at, :updated_at
class Item
  attr_accessor :attributes

  def initialize(data)
    # binding.pry
    modify(data)
    @attributes = data
  end

  def modify(data)
    # binding.pry
    data[:id] = data[:id].to_i
    data[:merchant_id] = data[:merchant_id].to_i
    data[:unit_price] = BigDecimal.new(data[:unit_price])/100
    data[:created_at] = Time.parse(data[:created_at])
    data[:updated_at] = Time.parse(data[:updated_at])
    data[:unit_price_to_dollars] = data[:unit_price].to_f
    # binding.pry
    data
  end

  def id
    @attributes[:id]
  end

  def name
    @attributes[:name]
  end

  def description
    @attributes[:description]
  end

  def merchant_id
    @attributes[:merchant_id]
  end

  def unit_price
    @attributes[:unit_price]
  end

  def created_at
    @attributes[:created_at]
  end

  def updated_at
    @attributes[:updated_at]
  end

  def unit_price_to_dollars
    @attributes[:unit_price].to_f
  end
end
