require 'time'
require 'bigdecimal'

class InvoiceItem
  attr_accessor :info

  def initialize(info)
    @info = info
    if @info[:unit_price].class != "BigDecimal"
      price_alt = @info[:unit_price].to_f/100
      @info[:unit_price] = price_alt
    end
  end

  def id
    @info[:id].to_i
  end

  def item_id
    @info[:item_id]
  end

  def invoice_id
    @info[:invoice_id]
  end

  def quantity
    @info[:quantity].to_i
  end

  def unit_price
    unit_price = BigDecimal(@info[:unit_price], 5)
  end

  def created_at
    Time.parse(@info[:created_at]).utc
  end

  def updated_at
    Time.parse(@info[:updated_at]).utc
  end

  def unit_price_to_dollars
    unit_price.to_f
  end
end
