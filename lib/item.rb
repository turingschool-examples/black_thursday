require 'time'
require 'bigdecimal'

class Item

  attr_accessor :info

  def initialize(info)
    @info = info
    if @info[:unit_price].class != "BigDecimal"
      price_alt = @info[:unit_price].to_f/100
      @info[:unit_price] = price_alt
    end
  end

  def id
    id = @info[:id].to_i
  end

  def name
    name = @info[:name]
  end

  def description
    description = @info[:description]
  end

  def unit_price
    # if @info[:unit_price].class != "BigDecimal"
    #     price_alt = @info[:unit_price].to_f
        unit_price = BigDecimal(@info[:unit_price], 5)
    # else
    #   @info[:unit_price]
    # end

  end

  def merchant_id
    merchant_id = @info[:merchant_id].to_i
  end

  def created_at
    created_at = Time.parse(@info[:created_at]).utc
  end

  def updated_at
    updated_at = Time.parse(@info[:updated_at]).utc
  end

  def unit_price_to_dollars
    unit_price.to_f
  end
end
